################################################################################
# Outputs
################################################################################

output "aws_s3_bucket_name" {
  description   = "Name of S3 bucket"
  value         = module.terrahouse.aws_s3_bucket_id
}
