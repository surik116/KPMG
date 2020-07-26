terraform {
  backend "s3" {
    bucket = "terraform-kpmg"
    key = "kpmg/bastion/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-kpmg"
    key    = "kpmg/vpc/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
  }
  workspace = terraform.workspace
}
