################################################################################
# Module Block
# AWS Buckets(s)
################################################################################

resource "aws_s3_bucket" "this" {
  count           = var.create ? 1 : 0

  bucket          = var.bucket
  acl             = var.acl
  tags            = var.tags
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration
resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  index_document {
    suffix        = "index.html"
  }
  error_document {
    key           = "error.html" 
  } 
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.this.bucket
  key    = "index.html"
  source = var.index_html_filepath

  etag = filemd5(var.index_html_filepath)
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.this.bucket
  key    = "error.html"
  source = var.error_html_filepath

  etag = filemd5(var.error_html_filepath)
}