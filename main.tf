################################################################################
# Provision Block
################################################################################

#provider "aws" {
#  region          = local.region  
#}

provider "terratowns" {
  endpoint      = "http://localhost:4567"
  user_uuid     = "e328f4ab-b99f-421c-84c9-4ccea042c7d1"
  token         = "9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
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
  assets_path     = var.assets_path
}

resource "terratowns_home" "home" {
  name = "How to play Arcanum in 2023!"
  description = <<EOF
Arcanum is a game from 2001 that shipped with alot of bugs.
Modders have removed all the originals making this game really fun
to play (despite that old look graphics). This is my g uide that will
show you how to play arcanum without spoiling the plot.
EOF
  domain_name = module.terrahouse.cloudfront_url
  town = "missingo"
  content_version = 1
}