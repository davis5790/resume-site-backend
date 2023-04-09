output "assume-role" {
  value = local.lambda-assume-policy
}

output "lambda-role" {
  value = local.lambda-iam-policy
}

output "lambda-role-arn" {
 value = local.lambda-assume-policy.arn
}