################################################################################
# Verion(s) and Requirement(s)
################################################################################
terraform {

  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
#    required_version = ">= 1.5.0"
#
#    required_providers {
#      aws = {
#        source  = "hashicorp/aws"
#        version = ">= 5.17.0"
#      }
#    }

#    cloud {
#    organization = "thevopz"

#    workspaces {
#      name = "root-tf"
#    }
#  }
}

