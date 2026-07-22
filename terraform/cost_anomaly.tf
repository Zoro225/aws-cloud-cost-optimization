resource "aws_ce_anomaly_monitor" "service_monitor" {

  name = "${var.project_name}-${var.environment}-service-monitor"

  monitor_type = "DIMENSIONAL"

  monitor_dimension = "SERVICE"

}


resource "aws_ce_anomaly_subscription" "cost_alert_subscription" {

  name = "${var.project_name}-${var.environment}-anomaly-alerts"

  frequency = "DAILY"

  monitor_arn_list = [
    aws_ce_anomaly_monitor.service_monitor.arn
  ]

  subscriber {

    type = "SNS"

    address = aws_sns_topic.cost_alerts.arn

  }

  threshold_expression {

    dimension {

      key = "ANOMALY_TOTAL_IMPACT_ABSOLUTE"

      values = [
        "10"
      ]

    }

  }

}
