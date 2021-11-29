resource "aws_lambda_function" "lambda" {
  depends_on = [
    data.archive_file.lambda_payload
  ]
  function_name = "img_upload_to_s3"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda.lambda_handler"
  runtime       = "python3.9"

  filename         = data.archive_file.lambda_payload.output_path
  source_code_hash = data.archive_file.lambda_payload.output_base64sha256
  timeout          = 60
}

data "archive_file" "lambda_payload" {
  type        = "zip"
  source_dir  = "${path.module}/../lambda_function/"
  output_path = "${path.module}/../img_upload_to_s3.zip"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${aws_api_gateway_rest_api.img_upload_lambda_gateway.id}/*/${aws_api_gateway_method.img_post_method.http_method}${aws_api_gateway_resource.img_upload_lambda_gateway_resource.path}"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_policy_s3"
  description = "IAM policy for Lambda image upload ot S3"
  policy      = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowPutToS3",
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": "*"
        }
    ]
}
  EOF
}

resource "aws_iam_role_policy_attachment" "attach_pttr_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
