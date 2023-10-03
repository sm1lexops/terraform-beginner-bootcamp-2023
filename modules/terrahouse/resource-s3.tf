################################################################################
# Module Block
# Storage S3 Resource(s)
################################################################################

resource "aws_s3_bucket" "this" {
  count           = var.create ? 1 : 0

  bucket          = var.bucket
  acl             = var.acl
  tags            = var.tags
}

resource "terraform_data" "content_version" {
  input         = var.content_version
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration
resource "aws_s3_bucket_website_configuration" "this" {

  bucket        = aws_s3_bucket.this[0].bucket
  index_document {
    suffix      = "index.html"
  }

  error_document {
    key         = "error.html"
  }
}
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "index_html" {
  bucket        = aws_s3_bucket.this[0].bucket
  key           = "index.html"
  source        = var.path_to_index
  content_type  = "text/html"
  etag          = filemd5(var.path_to_index)

  lifecycle {
    replace_triggered_by = [ terraform_data.content_version.output ]
    ignore_changes = [ etag ]
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "error_html" {
  bucket        = aws_s3_bucket.this[0].bucket
  key           = "error.html"
  source        = var.path_to_error
  content_type  = "text/html"
  etag          = filemd5(var.path_to_error)

  lifecycle {
    replace_triggered_by = [ terraform_data.content_version.output ]    
    ignore_changes = [ etag ]
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy
resource "aws_s3_bucket_policy" "oac" {
  bucket        = aws_s3_bucket.this[0].bucket
  policy        = jsonencode({
    "Version": "2012-10-17",
    "Statement": {
      "Sid": "AllowCloudFrontServicePrincipalReadOnly",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudfront.amazonaws.com"
      },
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::${aws_s3_bucket.this[0].id}/*",
        "Condition": {
          "StringEquals": {
            "AWS:SourceArn": "arn:aws:cloudfront::${data.aws_caller_identity.this.account_id}:distribution/${aws_cloudfront_distribution.s3static.id}"
          }
        }
    }
  })
}