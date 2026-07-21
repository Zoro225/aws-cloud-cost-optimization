provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "AWS Cloud Cost Optimization"
      Environment = "Dev"
      ManagedBy   = "Terraform"
      Owner       = "Amit"
    }
  }
}
