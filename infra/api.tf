
resource "aws_api_gateway_rest_api" "MyInterviewAPI" {
  name        = "MyInterviewAPI"
  description = "This is my API for interview purposes"
}

resource "aws_api_gateway_resource" "MyInterviewResource" {
  rest_api_id = aws_api_gateway_rest_api.MyInterviewAPI.id
  parent_id   = aws_api_gateway_rest_api.MyInterviewAPI.root_resource_id
  path_part   = "health"
}

resource "aws_api_gateway_method" "MyInterviewMethod" {
  rest_api_id   = aws_api_gateway_rest_api.MyInterviewAPI.id
  resource_id   = aws_api_gateway_resource.MyInterviewResource.id
  http_method   = "ANY"
  authorization = "NONE"
}


resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.MyInterviewAPI.id
  resource_id             = aws_api_gateway_resource.MyInterviewResource.id
  http_method             = aws_api_gateway_method.MyInterviewMethod.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:eu-west-2:lambda:path/2015-03-31/functions/${aws_lambda_function.test_lambda.arn}/invocations"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.arn
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:eu-west-2:${var.account_id}:${aws_api_gateway_rest_api.MyInterviewAPI.id}/*/${aws_api_gateway_method.MyInterviewMethod.http_method}${aws_api_gateway_resource.MyInterviewResource.path}"
}

resource "aws_api_gateway_deployment" "dev" {
  depends_on = [aws_api_gateway_integration.integration]
  rest_api_id = aws_api_gateway_rest_api.MyInterviewAPI.id
  stage_name = "dev"
}