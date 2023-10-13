################################################################################
# Provision Block
################################################################################

#provider "aws" {
#  region          = local.region  
#}

provider "terratowns" {
  endpoint        = var.terratowns_endpoint
  user_uuid       = var.user_uuid
  token           = var.terratowns_access_token
}

locals {
  region          = "eu-central-1"
  user_uuid       = var.user_uuid
} 

module "terratowns_missingo" {
  source          = "./modules/terrahouse"

  public_path     = var.missingo.public_path
  content_version = var.missingo.content_version 
  user_uuid       = var.user_uuid
}

resource "terratowns_home" "missingo" {
  name = "==== Rick & Morty. Who Are They??? ===="
  description = <<EOF
    "Rick and Morty" is an American animated science fiction sitcom created by Justin Roiland and Dan Harmon. The show first premiered in 2013 and has gained a dedicated fan following. 
    The series primarily focuses on the adventures of its two main characters, Rick Sanchez and Morty Smith.
    Rick Sanchez is an eccentric, brilliant, and often morally ambiguous scientist. He's known for his disregard for conventional rules and ethics. 
    Morty Smith, on the other hand, is Rick's easily influenced and somewhat naive grandson. Morty often finds himself reluctantly accompanying Rick on various interdimensional and extraterrestrial adventures.
  EOF

  domain_name = module.terrahouse.cloudfront_url
  town = "missingo"
  content_version = 1
}

module "terratowns_video_valley" {
  source          = "./modules/terrahouse"

  path_to_index   = var.path_to_index
  path_to_error   = var.path_to_error
  content_version = var.content_version 
  assets_path     = var.assets_path
  user_uuid       = var.user_uuid
}

resource "terratowns_home" "video_valley" {
  name = "==== Rick & Morty. Who Are They??? ===="
  description = <<EOF
    "Rick and Morty" is an American animated science fiction sitcom created by Justin Roiland and Dan Harmon. The show first premiered in 2013 and has gained a dedicated fan following. 
    The series primarily focuses on the adventures of its two main characters, Rick Sanchez and Morty Smith.
    Rick Sanchez is an eccentric, brilliant, and often morally ambiguous scientist. He's known for his disregard for conventional rules and ethics. 
    Morty Smith, on the other hand, is Rick's easily influenced and somewhat naive grandson. Morty often finds himself reluctantly accompanying Rick on various interdimensional and extraterrestrial adventures.
    The show blends elements of dark humor, satire, and absurdity. It explores a wide range of science fiction concepts, such as alternate dimensions, time travel, and advanced technology, while also addressing philosophical and ethical questions.
    "Rick and Morty" is celebrated for its clever writing, intricate plotlines, and its ability to mix humor with thought-provoking themes. 
    The show often delves into complex family dynamics and existential questions, all while maintaining a comedic and irreverent tone. 
    It's known for its pop culture references, unique characters, and distinctive animation style.
    Throughout the series, Rick and Morty encounter bizarre and otherworldly creatures, navigate complex family relationships, and often find themselves in perilous situations, all in the name of science, adventure, and sometimes just plain chaos.
    The show has received critical acclaim for its creative storytelling and has become a cultural phenomenon, spawning merchandise, fan theories, and a dedicated fanbase.
  EOF
  domain_name = module.terrahouse.cloudfront_url
  town = "missingo"
  content_version = 1
}