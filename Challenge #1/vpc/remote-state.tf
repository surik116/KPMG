terraform {
  backend "s3" {
    bucket = "terraform-kpmg"
    key = "kpmg/vpc/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}
