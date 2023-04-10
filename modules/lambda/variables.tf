variable "iam-role-name" {
  description = "The iam role used by the lambda function"
  default = "lambda-assume-role"
}

variable "assume-role-policy" {
    description = "lambda assume role policy"
    default = ""
}

variable "lambda-policy-name" {
    description = "lambda iam policy"
    default = "lambda-execution-policy"
}

variable "lambda-policy" {
    description = "the iam polity for the lambda function"
    default = ""
}

variable "archive-type" {
    description = "the type of archive file used"
    default = "zip"
}

variable "source-file" {
    description = "the source file for our lambda function"
    default = "view_counter.py"
}

variable "output-path" {
    description = "the name of our zipped source code file"
    default = "view_counter_function_payload.zip"
}

variable "function-name" {
    description = "the name of the lambda function"
    default = "view_counter"
}

variable "handler" {
    description = "the name of the lambda handler function"
    default = "view_counter.lambda_handler"
}

variable "runtime" {
    description = "the runtime used by the lambda function"
    default = "python3.9"
}

variable "alias-name" {
    description = "the name of the lambda alias to which our api points"
    default = "production"
}

variable "function-version" {
    description = "the version of our function used in the alias"
    default = "$LATEST"
}