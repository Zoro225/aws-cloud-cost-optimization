resource "aws_glue_crawler" "cost_crawler" {

  name = "${var.project_name}-${var.environment}-crawler"

  role = aws_iam_role.glue_role.arn

  database_name = aws_glue_catalog_database.cost_database.name


  s3_target {
    path = "s3://${module.cost_export_bucket.bucket_name}/cur/"
  }


  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }


  depends_on = [
    aws_iam_role_policy_attachment.glue_service_role
  ]
}
