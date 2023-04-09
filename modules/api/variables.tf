variable "api-gateway-name" {
    description = "the name of the api gateway created for the lambda function"
    default = "example-api-gateway"
}

variable "api-gateway-protocol" {
    description = "the transfer protocol used by our api"
    default = "HTTP"
}

variable "log-retention-period" {
    description = "the number of days to retain the logs"
    default = 7
}

variable "stage-name" {
   description = "the name of the gateway stage"
   default = "$default"
}

variable "log-format" {
    description = "the format of our cloudwatch log output"
    default = <<EOT
            requestId               = "$context.requestId"
            sourceIp                = "$context.identity.sourceIp"
            requestTime             = "$context.requestTime"
            protocol                = "$context.protocol"
            httpMethod              = "$context.httpMethod"
            status                  = "$context.status"
            responseLatency         = "$context.responseLatency"
            path                    = "$context.path"
            integrationErrorMessage = "$context.integrationErrorMessage"
        EOT
}

variable "integration-uri" {
  description = "the integration uri, follows format {lambda.arn}:{api_lambda_alias.name}"
  default = ""
}

variable "integration-type" {
  default = "AWS_PROXY"
}

variable "integration-method" {
  default = "POST"
}

variable "route-key" {
  default = "ANY /{proxy+}"
}

variable "lambda-function-name" {
  default = ""
}

variable "lambda-alias-name" {
  default= ""
}