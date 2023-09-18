terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "random" {
  # Configuration options
}

resource "random_string" "backet_name" {
    length      = 16
    special     = false
}
output "random_backet_name_string" {
    value = random_string.backet_name.id
}