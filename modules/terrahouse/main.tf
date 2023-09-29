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