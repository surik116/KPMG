provider "aws" {
  region = var.aws_region
  shared_credentials_file = "/home/vagrant/.aws/credentials"
}

variable "aws_region" {
  description = "AWS Region"
  default = "us-east-1"
}

variable "default_tags" {
  type = map(string)
  description = "A set of tags always included by default."
  default = {
    DeployTool = "Terraform"
  }
}

variable "entity_name" {
  description = "Company name"
  default = "kpmg.com"
}

variable "zones" {
  type = list(string)
  default = [
    "us-east-1a",
    "us-east-1b"
  ]
}
/*
* Dev VPC
*/
variable "dev_vpc_cidr" {
  description = "CIDR for the Dev VPC"
  default = "10.1.0.0/16"
}

variable "dev_public_subnets" {
  type = list(string)
  description = "A list of public subnets inside the VPC."
  default     = ["10.1.1.0/26", "10.1.2.0/26"]
}

variable "dev_private_subnets" {
  type = list(string)
  description = "A list of private subnets inside the VPC."
  default     = ["10.1.11.0/24", "10.1.12.0/24"]
}

variable "dev_database_subnets" {
  type        = list(string)
  description = "A list of database subnets"
  default     = ["10.1.21.0/24", "10.1.22.0/24"]
}

variable "dev_webapp_subnets" {
  type        = list(string)
  description = "A list of webapp subnets"
  default     = ["10.1.41.0/24", "10.1.42.0/24"]
}

variable "dev_elb_subnets" {
  type        = list(string)
  description = "A list of loadbalancer subnets"
  default     = ["10.1.61.0/24", "10.1.62.0/24"]
}

/*
* Test VPC
*/
variable "test_vpc_cidr" {
  description = "CIDR for the Dev VPC"
  default = "10.2.0.0/16"
}

variable "test_public_subnets" {
  type = list(string)
  description = "A list of public subnets inside the VPC."
  default     = ["10.2.1.0/26", "10.2.2.0/26"]
}

variable "test_private_subnets" {
  type = list(string)
  description = "A list of private subnets inside the VPC."
  default     = ["10.2.11.0/24", "10.2.12.0/24"]
}

variable "test_database_subnets" {
  type        = list(string)
  description = "A list of database subnets"
  default     = ["10.2.21.0/24", "10.2.22.0/24"]
}

variable "test_webapp_subnets" {
  type        = list(string)
  description = "A list of webapp subnets"
  default     = ["10.2.41.0/24", "10.2.42.0/24"]
}

variable "test_elb_subnets" {
  type        = list(string)
  description = "A list of loadbalancer subnets"
  default     = ["10.2.61.0/24", "10.2.62.0/24"]
}

/*
* Prod VPC
*/
variable "prod_vpc_cidr" {
  description = "CIDR for the Dev VPC"
  default = "10.3.0.0/16"
}

variable "prod_public_subnets" {
  type = list(string)
  description = "A list of public subnets inside the VPC."
  default     = ["10.3.1.0/26", "10.3.2.0/26"]
}

variable "prod_private_subnets" {
  type = list(string)
  description = "A list of private subnets inside the VPC."
  default     = ["10.3.11.0/24", "10.3.12.0/24"]
}

variable "prod_database_subnets" {
  type        = list(string)
  description = "A list of database subnets"
  default     = ["10.3.21.0/24", "10.3.22.0/24"]
}

variable "prod_webapp_subnets" {
  type        = list(string)
  description = "A list of webapp subnets"
  default     = ["10.3.41.0/24", "10.3.42.0/24"]
}

variable "prod_elb_subnets" {
  type        = list(string)
  description = "A list of loadbalancer subnets"
  default     = ["10.3.61.0/24", "10.3.62.0/24"]
}

variable "prod_account_id" {
  default = "111111111111"
}

variable "test_account_id" {
  default = "222222222222"
}

variable "dev_account_id" {
  default = "333333333333"
}