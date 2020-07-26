module "vpc" {
  source = "../modules/mod-vpc"

  name = "${terraform.workspace}-vpc"
  cidr = terraform.workspace == "prod" ? var.prod_vpc_cidr : terraform.workspace == "test" ? var.test_vpc_cidr : var.dev_vpc_cidr
  public_subnets = split(",", terraform.workspace == "prod" ?
  join(",", var.prod_public_subnets) :
  terraform.workspace == "test" ?
  join(",", var.test_public_subnets) :
  join(",", var.dev_public_subnets))
  private_subnets = split(",", terraform.workspace == "prod" ?
  join(",", var.prod_private_subnets) :
  terraform.workspace == "test" ?
  join(",", var.test_private_subnets) :
  join(",", var.dev_private_subnets))
  database_subnets = split(",", terraform.workspace == "prod" ?
  join(",", var.prod_database_subnets) :
  terraform.workspace == "test" ?
  join(",", var.test_database_subnets) :
  join(",", var.dev_database_subnets))
  webapp_subnets = split(",", terraform.workspace == "prod" ?
  join(",", var.prod_webapp_subnets) :
  terraform.workspace == "test" ?
  join(",", var.test_webapp_subnets) :
  join(",", var.dev_webapp_subnets))
  elb_subnets = split(",", terraform.workspace == "prod" ?
  join(",", var.prod_elb_subnets) :
  terraform.workspace == "test" ?
  join(",", var.test_elb_subnets) :
  join(",", var.dev_elb_subnets))
  azs = var.zones
  enable_dns_hostnames = true
  enable_dns_support = true
  enable_nat_gateway = false
  tags = {
    Environment = terraform.workspace
    DeployTool = "Terraform"
  }
}

// Setting up S3 endpoint for all private resources to access S3 internally without going out to internet
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id = module.vpc.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.s3"
}

// Setting up DynamoDB endpoint
resource "aws_vpc_endpoint" "dynamodb_endpoint" {
  vpc_id = module.vpc.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.dynamodb"
}

