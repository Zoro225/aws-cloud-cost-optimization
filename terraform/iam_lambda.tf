resource "aws_iam_role" "lambda_role" {

  name = "${var.project_name}-${var.environment}-lambda-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "lambda_basic" {

  role = aws_iam_role.lambda_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

}


resource "aws_iam_role_policy_attachment" "lambda_ec2" {

  role = aws_iam_role.lambda_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"

}


resource "aws_iam_role_policy" "lambda_sns_publish" {

  name = "${var.project_name}-${var.environment}-sns-policy"

  role = aws_iam_role.lambda_role.id

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "sns:Publish"
        ]

        Resource = aws_sns_topic.cost_alerts.arn
      }
    ]
  })
}





resource "aws_iam_role_policy_attachment" "lambda_cloudwatch" {

  role = aws_iam_role.lambda_role.name

  policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"

}




resource "aws_iam_role_policy" "lambda_cost_explorer" {

  name = "${var.project_name}-${var.environment}-cost-explorer-policy"

  role = aws_iam_role.lambda_role.id

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "ce:GetCostAndUsage"
        ]

        Resource = "*"
      }
    ]
  })
}
