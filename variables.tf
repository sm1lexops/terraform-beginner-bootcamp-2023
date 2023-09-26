variable "aws_access_key" {
  description = "AWS Access Key"
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
}

variable "aws_europe" {
  description = "EU AWS region "
}

#variable "aws_usa" {
#  description = "US AWS region "
#}

# Can set bucket name as variable and validate it
#variable "s3_bucket_name" {
#  description = "Name of the S3 bucket"
#  type        = string
#  validation {
#    condition     = can(length(var.s3_bucket_name) >= 8) && can(length(var.s3_bucket_name) <= 40)
#    error_message = "S3 bucket name must be between 8 and 40 characters in length"
#  }
#}

variable "user_uuid" {
  description = "The UUID of the user"
  type        = string
  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "user_uuid must be a valid UUID"
  }
}

