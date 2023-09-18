terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  
}
provider "random" {
  # Configuration options
}

resource "aws_s3_bucket" "my_random_s3_bucket" {
  bucket = "my-random-${random_string.bucket_name.id}"
}
resource "random_string" "bucket_name" {
  length  = 16
  special = false
  upper   = false
}
output "random_bucket_name_string" {
  value = random_string.bucket_name.id
}
output "my_random_s3_bucket" {
  value = aws_s3_bucket.my_random_s3_bucket.id
}
