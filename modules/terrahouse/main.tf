################################################################################
# Module Block
# AWS Buckets(s)
################################################################################

resource "aws_s3_bucket" "this" {
  count     = var.create ? 1 : 0

  user_uuid = var.user_uuid
  bucket    = var.bucket
  acl       = var.acl
  source    = var.file_source
  tags      = var.tags
}