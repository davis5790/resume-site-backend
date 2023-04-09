resource "aws_iam_role" "iam_for_lambda" {
  name = var.iam-role-name
  assume_role_policy = var.assume-role-policy
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = var.lambda-policy-name
  role = aws_iam_role.iam_for_lambda.id
  policy = var.lambda-policy
}

data "archive_file" "lambda" {
  type        = var.archive-type
  source_file = var.source-file
  output_path = var.output-path
}

resource "aws_lambda_function" "test_lambda" {
  filename      = var.output-path
  function_name = var.function-name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = var.handler
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime = var.runtime
}

/*
 * An alias allows us to point our
 * API gateway to a stable version of our function
 * which we can update as we want
 */
resource "aws_lambda_alias" "api_lambda_alias" {
  name             = var.alias-name
  function_name    = aws_lambda_function.test_lambda.arn
  function_version = var.function-version
}