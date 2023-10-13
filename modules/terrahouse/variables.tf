################################################################################
# Module Variable(s)
################################################################################
variable "create" {
  description   = "Create bucket or not"
  type          = bool
  default       = true 
}

#variable "bucket" {
#  description   = "The name of the s3 bucket"
#  type          = string
#  default       = ""
#
#  validation {
#    condition     = (
#      length(var.bucket) >= 10 && length(var.bucket) <= 60 && 
#      can(regex("^[a-z0-9][a-z0-9-.]*[a-z0-9]$", var.bucket))
#    )
#    error_message = "The bucket name must be between 10 and 60 characters, start and end with a lowercase letter or number, and can contain only lowercase letters, numbers, hyphens, and dots."
#  } 
#}

variable "tags" {
  description   = "A map of tags asign to the bucket"
  type          = map(string) 
  default = {}
}

variable "public_path" {
  description   = "Path to website assets"
  type          = string
}

variable "content_version" {
  description = "Positive integer content version"
  type        = number
  validation {
    condition     = var.content_version > 0 && floor(var.content_version) == var.content_version
    error_message = "content_version must be a positive integer starting at 1."
  }
}

variable "user_uuid" {
  type        = string
}