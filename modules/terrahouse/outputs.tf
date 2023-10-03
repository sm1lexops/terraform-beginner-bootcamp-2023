################################################################################
# Outputs
################################################################################

output "aws_s3_bucket_id" {
  description   = "Name of S3 bucket"
  value         = try(aws_s3_bucket.this[0].id, "")
}

output "website_endpoint" {
  value         = aws_s3_bucket_website_configuration.this.website_endpoint
}

output "cloudfront_url" {
  value         = aws_cloudfront_distribution.s3static.domain_name 
}