locals {
  lambda-assume-policy = jsondecode(file("/modules/iam/assume-policy.json"))

  lambda-iam-policy = jsondecode(file("/modules/iam/view-count-policy.json"))
}