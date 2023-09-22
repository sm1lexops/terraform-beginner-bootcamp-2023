terraform {
  cloud {
    organization = "thevopz"

    workspaces {
      name = "tfcloud"
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
provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "usa"
}

provider "random" {

}
resource "aws_s3_bucket" "my_random_s3_bucket" {
  bucket   = "eu-random-${random_string.bucket_name.id}"
  provider = aws
}

resource "aws_s3_bucket" "us_east_s3_bucket" {
  bucket   = "usa-random-${random_string.bucket_name.id}"
  provider = aws.usa
}
resource "random_string" "bucket_name" {
  provider = random
  length   = 16
  special  = false
  upper    = false
}

