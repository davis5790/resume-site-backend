/*
 * An API gateway to expose our function
 * to the Internet
 */
resource "aws_apigatewayv2_api" "api_gateway" {
  name          = var.api-gateway-name
  protocol_type = var.api-gateway-protocol
}

resource "aws_cloudwatch_log_group" "api_gateway_log_group" {
  name              = "/aws/api_gateway_log_group/${aws_apigatewayv2_api.api_gateway.name}"
  retention_in_days = var.log-retention-period
}

/*
 * Default stage for our API gateway
 * with basic access logs
 */
resource "aws_apigatewayv2_stage" "api_gateway_default_stage" {
  api_id      = aws_apigatewayv2_api.api_gateway.id
  name        = var.stage-name
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway_log_group.arn
    format = jsonencode(var.log-format)
  }
}

/*
 * Integrate our function with our API gateway
 * so that they can communicate
 */
resource "aws_apigatewayv2_integration" "api_gateway_integration" {
  api_id             = aws_apigatewayv2_api.api_gateway.id
  integration_uri    = var.integration-uri
  integration_type   = var.integration-type
  integration_method = var.integration-method
}

/*
 * Tell our API gateway to forward all incoming
 * requests (every path + HTTP verb) to our function
 */
resource "aws_apigatewayv2_route" "api_gateway_any_route" {
  api_id               = aws_apigatewayv2_api.api_gateway.id
  route_key            = var.route-key
  target               = "integrations/${aws_apigatewayv2_integration.api_gateway_integration.id}"
}

/*
 * Allow our API gateway to invoke our function
 */
resource "aws_lambda_permission" "api_gateway_lambda_permission" {
  principal     = "apigateway.amazonaws.com"
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda-function-name
  qualifier     = var.lambda-alias-name
  source_arn    = "${aws_apigatewayv2_api.api_gateway.execution_arn}/*/*"
}