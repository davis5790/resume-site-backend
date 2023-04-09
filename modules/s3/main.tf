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