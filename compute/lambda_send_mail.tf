data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "./compute/lambda_function_send_mail.py"
  output_path = "./compute/lambda_function_send_mail_py.zip"
}

resource "aws_iam_policy" "lambda_ses_policy" {
  name        = "lambda_ses_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ses:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_ses_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_ses_policy.arn
  role       = aws_iam_role.iam_for_lambda.name
}

resource "aws_lambda_function" "test_lambda" {
  filename      = "./compute/lambda_function_send_mail_py.zip"
  function_name = "send_mail"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function_send_mail.lambda_handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.13"
}
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::terraform-state-lock-aws-bucket"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "terraform-state-lock-aws-bucket"

  lambda_function {
    lambda_function_arn = aws_lambda_function.test_lambda.arn
    events              = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]
    filter_suffix = ".state"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}
