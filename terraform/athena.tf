resource "aws_athena_workgroup" "cost_analysis" {

  name = "${var.project_name}-${var.environment}-workgroup"

  configuration {

    enforce_workgroup_configuration = true

    result_configuration {
      output_location = "s3://${module.athena_results_bucket.bucket_name}/results/"
    }
  }
}

