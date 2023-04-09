// S3 bucket in which we're gonna release our versioned zip archives
resource "aws_s3_bucket" "api_bucket" {
  bucket        = var.bucket-name
  force_destroy = true
}

/*
 * The first archive is uploaded through Terraform
 * The following ones will be uploaded by our CI/CD. pipeline in GitHub actions
 */
resource "aws_s3_bucket_object" "api_code_archive" {
  bucket = aws_s3_bucket.api_bucket.id
  key    = "view_counter.zip"
  source = var.archive-output-path
  etag   = filemd5(var.archive-output-path)
}

resource "aws_s3_bucket_policy" "allow_PutObject" {
  bucket = aws_s3_bucket.api_bucket.id
  policy = data.aws_iam_policy_document.allow_PutObject.json
}

data "aws_iam_policy_document" "allow_PutObject" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [var.bucket-policy-iam-role]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject"
    ]

    resources = [
      aws_s3_bucket.api_bucket.arn,
      "${aws_s3_bucket.api_bucket.arn}/*",
    ]
  }
}