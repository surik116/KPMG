output "private_subnets" {
  value = aws_subnet.private.*.id
}

output "database_subnets" {
  value = aws_subnet.database.*.id
}

output "database_subnet_group" {
  value = aws_db_subnet_group.database.*.id
}

output "database_subnet_group_name" {
  value = aws_db_subnet_group.database.name
}

output "public_subnets" {
  value = aws_subnet.public.*.id
}

output "webapp_subnets" {
  value = aws_subnet.webapp.*.id
}

output "elb_subnets" {
  value = aws_subnet.elb.*.id
}

output "vpc_id" {
  value = aws_vpc.mod.id
}

output "public_route_table_ids" {
  value = aws_route_table.public.*.id
}

output "private_route_table_ids" {
  value = aws_route_table.private.*.id
}

output "database_route_table_ids" {
  value = aws_route_table.database.*.id
}

output "webapp_route_table_ids" {
  value = aws_route_table.webapp.*.id
}

output "elb_route_table_ids" {
  value = aws_route_table.elb.*.id
}

output "igw_id" {
  value = aws_internet_gateway.mod.id
}

output "cidr" {
  value = aws_vpc.mod.cidr_block
}

output "public_subnet_cidrs" {
  value = aws_subnet.public.*.cidr_block
}

output "private_subnet_cidrs" {
  value = aws_subnet.private.*.cidr_block
}

output "nat_subnet_cidrs" {
  value = aws_subnet.nat.*.cidr_block
}

output "elb_subnet_cidrs" {
  value = aws_subnet.elb.*.cidr_block
}

output "webapp_subnet_cidrs" {
  value = aws_subnet.webapp.*.cidr_block
}

output "database_subnet_cidrs" {
  value = aws_subnet.database.*.cidr_block
}
