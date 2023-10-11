################################################################################
# Module Variable(s)
################################################################################
variable "create" {
  description   = "Create bucket or not"
  type          = bool
  default       = true 
}

variable "bucket" {
  description   = "The name of the s3 bucket"
  type          = string
  default       = ""

  validation {
    condition     = (
      length(var.bucket) >= 10 && length(var.bucket) <= 60 && 
      can(regex("^[a-z0-9][a-z0-9-.]*[a-z0-9]$", var.bucket))
    )
    error_message = "The bucket name must be between 10 and 60 characters, start and end with a lowercase letter or number, and can contain only lowercase letters, numbers, hyphens, and dots."
  } 
}

variable "tags" {
  description   = "A map of tags asign to the bucket"
  type          = map(string) 
  default = {}
}

variable "path_to_index" {
  description   = "Path to index.html"
  type          = string
  validation {
  condition     = fileexists(var.path_to_index)
  error_message = "The provided path for index.html does not exist."
  }
}

variable "path_to_error" {
  description   = "Path to error.html"
  type          = string
  validation {
  condition     = fileexists(var.path_to_error)
  error_message = "The provided path for error.html does not exist."
  }
}

variable "content_version" {
  description = "Positive integer content version"
  type        = number
  validation {
    condition     = var.content_version > 0 && floor(var.content_version) == var.content_version
    error_message = "content_version must be a positive integer starting at 1."
  }
}

variable "assets_path" {
  description = "Path to Assets"
  type        = string
}