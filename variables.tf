variable "user_uuid" {
  description = "User UUID as well as uuid exam.pro account"
  type        = string
  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "user_uuid must be a valid UUID"
  }
}

variable "file_source" {
  description   = "The path fo file that will be read and uploaded as raw"
  type          = string
  default       = null
}

variable "path_to_index" {
  type          = string
}

variable "path_to_error" {
  type          = string
}

variable "content_version" {
  type          = number 
}     

variable "assets_path" {
  type          = string 
}     