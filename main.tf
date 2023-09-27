################################################################################
# Provision Block
################################################################################

provider "aws" {
  region      = local.region  
}

locals {
  region      = "eu-central-1"
} 
module "terrahouse" {
  source      = "./modules/terrahouse"

  user_uuid   = "c7f8d132-bac3-41e5-8cfc-f35779b73f8f"
  bucket      = "my-bucket-c7f8d132-bac3-41e5-8cfc-f35779b73f8f"
}