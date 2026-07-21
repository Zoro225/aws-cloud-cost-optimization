output "cost_export_bucket_name" {
  value = module.cost_export_bucket.bucket_name
}

output "athena_results_bucket_name" {
  value = module.athena_results_bucket.bucket_name
}


output "sns_topic_arn" {

  description = "SNS topic ARN for cost alerts"

  value = aws_sns_topic.cost_alerts.arn

}
