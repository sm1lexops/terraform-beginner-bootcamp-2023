################################################################################
# Variable(s)
################################################################################
variable "create" {
  description   = "Create bucket or not"
  type          = bool
  default       = true 
}

variable "user_uuid" {
  description = "User UUID as well as uuid exam.pro account"
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "user_uuid must be a valid UUID"
  }
}

variable "bucket" {
  description   = "The name of the s3 bucket"
  type          = string
  default       = ""

  validation {
    condition     = (
      length(var.bucket) >= 10 && length(var.bucket) <= 40 && 
      can(regex("^[a-z0-9][a-z0-9-.]*[a-z0-9]$", var.bucket))
    )
    error_message = "The bucket name must be between 10 and 40 characters, start and end with a lowercase letter or number, and can contain only lowercase letters, numbers, hyphens, and dots."
  } 
}

variable "file_source" {
  description   = "The path fo file that will be read and uploaded as raw"
  type          = string
  default       = null
}

variable "acl" {
  description   = "The ACL linked to the bucket"
  type          = string 
  default = null
}

variable "tags" {
  description   = "A map of tags asign to the bucket"
  type          = map(string) 
  default = {}
}