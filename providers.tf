provider "aws" {
  region = var.aws_europe
}

provider "aws" {
  region = var.aws_usa
  alias = "usa"
}

provider "random" {
  
}