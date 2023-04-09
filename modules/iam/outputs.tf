output "assume-role" {
  value = local.lambda-assume-policy
}

output "lambda-role" {
  value = local.lambda-iam-policy
}