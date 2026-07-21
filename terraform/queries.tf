resource "aws_athena_named_query" "total_cost" {

  name = "total-monthly-cost"

  database = aws_glue_catalog_database.cost_database.name

  workgroup = aws_athena_workgroup.cost_analysis.name

  query = <<EOF
SELECT
    SUM(line_item_unblended_cost) AS total_cost
FROM cost_and_usage_report
WHERE bill_billing_period_start_date =
date_trunc('month', current_date);
EOF
}


resource "aws_athena_named_query" "service_cost" {

  name = "service-wise-cost"

  database = aws_glue_catalog_database.cost_database.name

  workgroup = aws_athena_workgroup.cost_analysis.name

  query = <<EOF
SELECT
    line_item_product_code AS service,
    SUM(line_item_unblended_cost) AS cost
FROM cost_and_usage_report
GROUP BY line_item_product_code
ORDER BY cost DESC;
EOF
}


resource "aws_athena_named_query" "resource_cost" {

  name = "top-expensive-resources"

  database = aws_glue_catalog_database.cost_database.name

  workgroup = aws_athena_workgroup.cost_analysis.name

  query = <<EOF
SELECT
    resource_id,
    line_item_product_code,
    SUM(line_item_unblended_cost) AS cost
FROM cost_and_usage_report
GROUP BY resource_id, line_item_product_code
ORDER BY cost DESC
LIMIT 20;
EOF
}
