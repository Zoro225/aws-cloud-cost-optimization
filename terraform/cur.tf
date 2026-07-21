resource "aws_cur_report_definition" "cost_report" {
  report_name                = "${var.project_name}-cur-report"
  time_unit                  = "HOURLY"
  format                     = "Parquet"
  compression                = "Parquet"
  additional_schema_elements = ["RESOURCES"]

  additional_artifacts = [
    "ATHENA"
  ]

  s3_bucket = module.cost_export_bucket.bucket_name
  s3_prefix = "cur"
  s3_region = var.aws_region

  refresh_closed_reports = true

  report_versioning = "OVERWRITE_REPORT"
}
