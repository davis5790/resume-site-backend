output "lambda-function-arn" {
    value = aws_lambda_function.test_lambda.arn
}

output "lambda-function-name" {
    value = aws_lambda_function.test_lambda.function_name
}

output "lambda-alias-name" {
    value = aws_lambda_alias.api_lambda_alias.name
}

output "lambda-output-path" {
    value = data.archive_file.lambda.output_path
}