################################################################################
# Verion(s) and Requirement(s)
################################################################################
terraform {
    required_version = ">= 1.5.0"

    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = ">= 5.17.0"
      }
    }

    cloud {
    organization = "thevopz"

    workspaces {
      name = "root-tf"
    }
  }
}