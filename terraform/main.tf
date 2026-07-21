resource "random_id" "bucket_suffix" {
  byte_length = 4
}

module "cost_export_bucket" {
  source = "./modules/s3"

  bucket_name  = "${var.project_name}-${var.environment}-cost-export-${random_id.bucket_suffix.hex}"
  project_name = var.project_name
  environment  = var.environment
}

module "athena_results_bucket" {
  source = "./modules/s3"

  bucket_name  = "${var.project_name}-${var.environment}-athena-results-${random_id.bucket_suffix.hex}"
  project_name = var.project_name
  environment  = var.environment
}
