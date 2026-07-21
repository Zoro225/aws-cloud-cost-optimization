import boto3
import os
from datetime import datetime, timedelta


ec2 = boto3.client("ec2")
sns = boto3.client("sns")
cloudwatch = boto3.client("cloudwatch")


SNS_TOPIC_ARN = os.environ["SNS_TOPIC_ARN"]


def lambda_handler(event, context):

    recommendations = []

    # EC2 checks
    instances = ec2.describe_instances()

    for reservation in instances["Reservations"]:
        for instance in reservation["Instances"]:

            if instance["State"]["Name"] == "running":

                instance_id = instance["InstanceId"]
                instance_type = instance["InstanceType"]

                # Get CPU utilization for last 7 days
                cpu = cloudwatch.get_metric_statistics(
                    Namespace="AWS/EC2",
                    MetricName="CPUUtilization",
                    Dimensions=[
                        {
                            "Name": "InstanceId",
                            "Value": instance_id
                        }
                    ],
                    StartTime=datetime.utcnow() - timedelta(days=7),
                    EndTime=datetime.utcnow(),
                    Period=86400,
                    Statistics=["Average"]
                )


                if cpu["Datapoints"]:

                    avg_cpu = sum(
                        point["Average"]
                        for point in cpu["Datapoints"]
                    ) / len(cpu["Datapoints"])


                    if avg_cpu < 10:

                        recommendations.append(
                            f"""
🚨 EC2 Rightsizing Recommendation

Instance ID:
{instance_id}

Instance Type:
{instance_type}

Average CPU (7 days):
{avg_cpu:.2f}%

Finding:
Low CPU utilization detected.

Recommendation:
Review workload and consider downsizing.
"""
                        )


                else:

                    recommendations.append(
                        f"""
ℹ️ EC2 Instance Review

Instance ID:
{instance_id}

Instance Type:
{instance_type}

Finding:
No CPU metrics available.

Recommendation:
Review instance usage manually.
"""
                    )


    # Unattached EBS volumes
    volumes = ec2.describe_volumes(
        Filters=[
            {
                "Name": "status",
                "Values": ["available"]
            }
        ]
    )


    for volume in volumes["Volumes"]:

        recommendations.append(
            f"""
🚨 Unused EBS Volume

Volume ID:
{volume['VolumeId']}

Size:
{volume['Size']} GB

Status:
Available

Recommendation:
Delete after verification.
Unused volumes continue generating storage cost.
"""
        )


    # Unused Elastic IPs
    addresses = ec2.describe_addresses()


    for address in addresses["Addresses"]:

        if "InstanceId" not in address:

            recommendations.append(
                f"""
🚨 Unused Elastic IP

Allocation ID:
{address['AllocationId']}

Recommendation:
Release unused Elastic IP.
"""
            )


    # Send SNS notification
    if recommendations:

        message = "\n".join(recommendations)

        sns.publish(
            TopicArn=SNS_TOPIC_ARN,
            Subject="AWS Cost Optimization Recommendations",
            Message=message
        )


    return {
        "statusCode": 200,
        "body": "Cost optimization check completed"
    }
