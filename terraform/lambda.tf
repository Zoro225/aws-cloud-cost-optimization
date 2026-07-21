data "archive_file" "cost_optimizer" {

  type = "zip"

  source_dir = "${path.module}/lambda"

  output_path = "${path.module}/cost_optimizer.zip"

}


resource "aws_lambda_function" "cost_optimizer" {

  filename = data.archive_file.cost_optimizer.output_path

  function_name = "${var.project_name}-${var.environment}-optimizer"

  role = aws_iam_role.lambda_role.arn

  handler = "cost_optimizer.lambda_handler"

  runtime = "python3.12"

  source_code_hash = data.archive_file.cost_optimizer.output_base64sha256


  environment {

    variables = {

      SNS_TOPIC_ARN = aws_sns_topic.cost_alerts.arn

    }

  }

}
