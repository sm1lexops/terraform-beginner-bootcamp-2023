resource "aws_s3_bucket" "tf_bucket" {
  bucket = "eu-tf-bucket-${var.user_uuid}"
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

