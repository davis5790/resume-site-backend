module "iam" {
  source = "./modules/iam"

}

module "s3" {
  source      = "./modules/s3"
  bucket-name = "view-counter-api-bucket-42"
  archive-output-path = module.lambda.lambda-output-path
  bucket-policy-iam-role = module.lambda.lambda-role-arn
}

module "lambda" {
  source = "./modules/lambda"
  assume-role-policy = jsondecode(file("./modules/iam/assume-policy.json"))
  lambda-policy = jsondecode(file("./modules/iam/view-count-policy.json"))
}

module "api" {
  source               = "./modules/api"
  integration-uri      = "${module.lambda.lambda-function-arn}:${module.lambda.lambda-alias-name}"
  lambda-function-name = module.lambda.lambda-function-name
  lambda-alias-name = module.lambda.lambda-alias-name

}