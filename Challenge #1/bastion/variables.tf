provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "AWS Region"
  default = "us-east-1"
}
