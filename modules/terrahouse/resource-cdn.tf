################################################################################
# Module Block
# AWS Cloud Distribution Network(s)
################################################################################

locals {
  s3_origin_id = "MyS3Origin"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control
resource "aws_cloudfront_origin_access_control" "s3static" {
  name                              = "OAC-${var.bucket}"
  description                       = "Origin Access Control for Static Website Hosting ${var.bucket}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution
resource "aws_cloudfront_distribution" "s3static" {
  origin {
    domain_name              = aws_s3_bucket.this[0].bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.s3static.id
    origin_id                = local.s3_origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Static website hosting for: ${var.bucket}"
  default_root_object = "index.html"

  #aliases = ["mysite.example.com", "yoursite.example.com"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
