resource "aws_cloudwatch_event_rule" "cost_optimizer_schedule" {

  name = "${var.project_name}-${var.environment}-schedule"

  description = "Daily AWS cost optimization check"

  schedule_expression = "rate(1 day)"

}


resource "aws_cloudwatch_event_target" "lambda_target" {

  rule = aws_cloudwatch_event_rule.cost_optimizer_schedule.name

  target_id = "cost-optimizer-lambda"

  arn = aws_lambda_function.cost_optimizer.arn

}


resource "aws_lambda_permission" "allow_eventbridge" {

  statement_id = "AllowEventBridgeInvoke"

  action = "lambda:InvokeFunction"

  function_name = aws_lambda_function.cost_optimizer.function_name

  principal = "events.amazonaws.com"

  source_arn = aws_cloudwatch_event_rule.cost_optimizer_schedule.arn

}
