################################################################################
# Outputs
################################################################################

output "aws_s3_bucket_name" {
  description   = "Name of S3 bucket"
  value         = module.terratowns_video_valley.aws_s3_bucket_id
}

output "aws_s3_website_endpoint" {
  description = "AWS S3 Website Endpoint"
  value = module.terratowns_video_valley.website_endpoint
}

output "cloudfront_url" {
  description = "CloudFront URL"
  value = module.terratowns_video_valley.cloudfront_url
}