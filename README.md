# AWS Cloud Cost Optimization & FinOps Automation Platform

![AWS](https://img.shields.io/badge/AWS-Cloud-orange)
![Terraform](https://img.shields.io/badge/IaC-Terraform-purple)
![Python](https://img.shields.io/badge/Lambda-Python-blue)
![Athena](https://img.shields.io/badge/Athena-Analytics-green)

## Overview

This project implements an automated **AWS FinOps and Cloud Cost Optimization Platform** that helps organizations monitor cloud spending, analyze usage patterns, identify optimization opportunities, and receive cost alerts.

The platform uses AWS native services with Terraform Infrastructure as Code to automate the complete cost monitoring workflow.

The solution provides:

- AWS cost analysis automation
- EC2 utilization monitoring
- Cost optimization recommendations
- Cost Explorer integration
- Cost & Usage Report (CUR) analytics pipeline
- Athena-based cost queries
- Email notifications for cost alerts


---

# Architecture

```
                         AWS Billing
                              |
              +---------------+---------------+
              |                               |
              v                               v

       Cost Explorer API              Cost & Usage Report
              |                               |
              v                               v

          Lambda                    Amazon S3 Bucket
              |                               |
              |                               v
              |                         Glue Crawler
              |                               |
              |                               v
              |                     Glue Data Catalog
              |                               |
              |                               v
              |                           Athena
              |                               |
              +---------------+---------------+
                              |
                              v

                     FinOps Dashboard
                     (QuickSight)

                              |
                              v

                         SNS Alerts
                              |
                              v

                          Email
```

---

# Features

## 1. Automated Infrastructure Provisioning

Infrastructure is created using Terraform:

- S3 buckets
- IAM roles and policies
- Lambda functions
- SNS notifications
- EventBridge scheduling
- Glue resources
- Athena resources


---

## 2. AWS Cost Explorer Integration

The platform integrates with AWS Cost Explorer API to retrieve:

- Monthly AWS spending
- Service-level costs
- Usage trends
- Cost analysis data


Example:

```
AWS Cost Explorer API
          |
          v
       Lambda
          |
          v
  Cost Optimization Report
```


---

## 3. EC2 Cost Optimization

The Lambda function analyzes EC2 utilization metrics and identifies optimization opportunities.

Capabilities:

- CPU utilization analysis
- Underutilized instance detection
- Rightsizing recommendations


Example recommendation:

```
Instance:
t3.medium

Average CPU:
5%

Recommendation:
Consider downsizing instance type
```

---

## 4. AWS Cost & Usage Report Pipeline

The project configures AWS CUR for detailed billing analytics.


Workflow:

```
AWS CUR
  |
  v
Amazon S3
  |
  v
Glue Crawler
  |
  v
Glue Catalog
  |
  v
Athena Queries
```

Provides:

- Resource-level cost analysis
- Service cost breakdown
- Historical cost reporting


---

## 5. Athena Cost Analysis Queries

Implemented Athena queries:

### Total Monthly Cost

Calculates total AWS spending.

### Service-wise Cost

Shows cost distribution across AWS services.

### Top Expensive Resources

Identifies highest-cost resources.

---

## 6. Automated Email Alerts

SNS notifications provide:

- Cost optimization reports
- Budget-related alerts
- Automated recommendations


Flow:

```
Lambda
  |
  v
SNS Topic
  |
  v
Email Notification
```

---

# Technologies Used

## Cloud

- AWS EC2
- AWS Cost Explorer
- AWS Cost & Usage Reports
- AWS S3
- AWS Lambda
- AWS Glue
- AWS Athena
- AWS SNS
- AWS EventBridge
- AWS IAM


## Infrastructure as Code

- Terraform


## Programming

- Python


## Data Analytics

- Athena SQL
- Glue Data Catalog


---

# Terraform Structure

```
terraform/

├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
│
├── cur.tf
├── glue.tf
├── crawler.tf
├── athena.tf
├── queries.tf
├── lambda.tf
├── sns.tf
├── eventbridge.tf
│
└── modules/

    ├── s3/
    ├── iam/
    ├── lambda/
    ├── sns/
    └── eventbridge/
```

---

# Deployment

## Clone Repository

```bash
git clone <repository-url>

cd aws-cost-optimization
```

---

## Configure AWS Credentials

```bash
aws configure
```

Required permissions:

- Terraform resource creation permissions
- Cost Explorer access
- S3 access
- Lambda permissions


---

## Initialize Terraform

```bash
cd terraform

terraform init
```

---

## Validate Configuration

```bash
terraform validate
```

---

## Create Infrastructure

```bash
terraform plan

terraform apply
```

---

# Verification

## Check Lambda

```bash
aws lambda list-functions
```

## Check Glue Crawler

```bash
aws glue list-crawlers
```

## Check Athena Workgroup

```bash
aws athena list-work-groups
```

## Check SNS Topics

```bash
aws sns list-topics
```

---

# Future Enhancements

Planned improvements:

- AWS QuickSight FinOps Dashboard
- Cost forecasting
- Budget automation
- Multi-account cost aggregation
- Slack/Teams notifications
- Machine learning based optimization recommendations


---

# Project Outcome

This project demonstrates practical implementation of:

- Cloud Cost Optimization
- FinOps principles
- Infrastructure as Code
- AWS automation
- Serverless architecture
- Cloud analytics pipelines


---

# Author

**Amit Jadhav**

Cloud / DevOps Engineer

Skills:
AWS | Terraform | Docker | Kubernetes | CI/CD | Linux
