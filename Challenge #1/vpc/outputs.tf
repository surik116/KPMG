output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_igw_id" {
  value = module.vpc.igw_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "database_subnets" {
  value = module.vpc.database_subnets
}

output "webapp_subnets" {
  value = module.vpc.webapp_subnets
}

output "elb_subnets" {
  value = module.vpc.elb_subnets
}

output "database_subnet_group" {
  value = module.vpc.database_subnet_group
}

output "database_subnet_group_name" {
  value = module.vpc.database_subnet_group_name
}

output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}

output "public_route_table_ids" {
  value = module.vpc.public_route_table_ids
}

output "database_route_table_ids" {
  value = module.vpc.database_route_table_ids
}

output "webapp_route_table_ids" {
  value = module.vpc.webapp_route_table_ids
}

output "elb_route_table_ids" {
  value = module.vpc.elb_route_table_ids
}

output "cidr" {
  value = module.vpc.cidr
}

output "public_subnet_cidrs" {
  value = module.vpc.public_subnet_cidrs
}

output "private_subnet_cidrs" {
  value = module.vpc.private_subnet_cidrs
}

output "nat_subnet_cidrs" {
  value = module.vpc.nat_subnet_cidrs
}

output "elb_subnet_cidrs" {
  value = module.vpc.elb_subnet_cidrs
}

output "webapp_subnet_cidrs" {
  value = module.vpc.webapp_subnet_cidrs
}

output "database_subnet_cidrs" {
  value = module.vpc.database_subnet_cidrs
}

output "account_id" {
  value = terraform.workspace == "prod" ? var.prod_account_id : terraform.workspace == "test" ? var.test_account_id : var.dev_account_id
}