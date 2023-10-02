################################################################################
# Module Block
# AWS Buckets(s)
################################################################################

locals {
  
}

resource "aws_s3_bucket" "this" {
  count           = var.create ? 1 : 0

  bucket          = var.bucket
  acl             = var.acl
  tags            = var.tags
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration
resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.this[0].bucket
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.this[0].bucket
  key    = "index.html"
  source = var.path_to_index

  etag = filemd5(var.path_to_index)
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.this[0].bucket
  key    = "error.html"
  source = var.path_to_error

  etag = filemd5(var.path_to_error)
}