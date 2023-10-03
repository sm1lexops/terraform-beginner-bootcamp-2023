################################################################################
# Provision Block
################################################################################

provider "aws" {
  region          = local.region  
}

locals {
  region          = "eu-central-1"
  user_uuid       = var.user_uuid
} 
module "terrahouse" {
  source          = "./modules/terrahouse"

  bucket          = "my-bucket-c7f8d132-bac3-41e5-8cfc-f35779b73f8f"
  path_to_index   = var.path_to_index
  path_to_error   = var.path_to_error
  content_version = var.content_version 
}