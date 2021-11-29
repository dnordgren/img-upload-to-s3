resource "aws_api_gateway_rest_api" "img_upload_lambda_gateway" {
  name = "img_upload_lambda_gateway"
}

resource "aws_api_gateway_resource" "img_upload_lambda_gateway_resource" {
  parent_id   = aws_api_gateway_rest_api.img_upload_lambda_gateway.root_resource_id
  path_part   = "img"
  rest_api_id = aws_api_gateway_rest_api.img_upload_lambda_gateway.id
}

resource "aws_api_gateway_method" "img_post_method" {
  authorization = "NONE"
  http_method   = "POST"
  resource_id   = aws_api_gateway_resource.img_upload_lambda_gateway_resource.id
  rest_api_id   = aws_api_gateway_rest_api.img_upload_lambda_gateway.id
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.img_upload_lambda_gateway.id
  resource_id             = aws_api_gateway_resource.img_upload_lambda_gateway_resource.id
  http_method             = aws_api_gateway_method.img_post_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda.invoke_arn
}
