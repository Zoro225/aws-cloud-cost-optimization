import boto3
import os


ec2 = boto3.client("ec2")
sns = boto3.client("sns")


SNS_TOPIC_ARN = os.environ["SNS_TOPIC_ARN"]


def lambda_handler(event, context):

    findings = []

    # Check EC2 instances
    instances = ec2.describe_instances()

    for reservation in instances["Reservations"]:
        for instance in reservation["Instances"]:

            if instance["State"]["Name"] == "running":

                findings.append(
                    f"Running EC2 instance: {instance['InstanceId']}"
                )


    # Check unattached volumes
    volumes = ec2.describe_volumes(
        Filters=[
            {
                "Name": "status",
                "Values": ["available"]
            }
        ]
    )

    for volume in volumes["Volumes"]:

        findings.append(
            f"Unused EBS Volume: {volume['VolumeId']}"
        )


    # Check Elastic IPs
    addresses = ec2.describe_addresses()

    for address in addresses["Addresses"]:

        if "InstanceId" not in address:

            findings.append(
                f"Unused Elastic IP: {address['AllocationId']}"
            )


    if findings:

        message = "\n".join(findings)

        sns.publish(
            TopicArn=SNS_TOPIC_ARN,
            Subject="AWS Cost Optimization Alert",
            Message=message
        )


    return {
        "statusCode": 200,
        "body": "Cost check completed"
    }
