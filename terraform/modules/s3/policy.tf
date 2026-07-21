resource "aws_s3_bucket_policy" "cur_policy" {
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "AllowBillingReportsService"
        Effect = "Allow"

        Principal = {
          Service = "billingreports.amazonaws.com"
        }

        Action = [
          "s3:GetBucketAcl",
          "s3:GetBucketPolicy",
          "s3:ListBucket"
        ]

        Resource = aws_s3_bucket.this.arn
      },

      {
        Sid    = "AllowBillingReportsWrite"
        Effect = "Allow"

        Principal = {
          Service = "billingreports.amazonaws.com"
        }

        Action = [
          "s3:PutObject"
        ]

        Resource = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}
