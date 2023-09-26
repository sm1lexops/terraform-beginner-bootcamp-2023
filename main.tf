terraform {
    cloud {
    organization = "thevopz"

    workspaces {
      name = "root-tf"
    }
  }
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17.0"
    }
  }
}

resource "aws_s3_bucket" "my_random_s3_bucket" {
  bucket = "eu-random-${random_string.bucket_name.id}"
  provider = aws
  
  tags = {
    tf_user_uuid = var.user_uuid
    description = "Terraform Bootcamp User uuid"
  }
}

# If we want to create another bucket, using another name prefix
#resource "aws_s3_bucket" "us_east_s3_bucket" {
#  bucket = "usa-random-${random_string.bucket_name.id}"
#  provider = aws.usa
#}
resource "random_string" "bucket_name" {
  provider = random
  length  = 16
  special = false
  upper   = false
}
