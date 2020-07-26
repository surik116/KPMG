resource "aws_vpc" "mod" {
  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags                 = merge(var.tags, map("Name", format("%s", var.name)))
}

resource "aws_internet_gateway" "mod" {
  vpc_id = aws_vpc.mod.id
  tags   = merge(var.tags, map("Name", format("%s-igw", var.name)))
}

// Route tables (public)
resource "aws_route_table" "public" {
  vpc_id           = aws_vpc.mod.id
  propagating_vgws = var.public_propagating_vgws
  tags             = merge(var.tags, map("Name", format("%s-rt-public", var.name)))
}

resource "aws_route_table" "nat" {
  vpc_id           = aws_vpc.mod.id
  propagating_vgws = var.public_propagating_vgws
  tags             = merge(var.tags, map("Name", format("%s-rt-nat", var.name)))
}

resource "aws_route_table" "elb" {
  vpc_id           = aws_vpc.mod.id
  propagating_vgws = var.public_propagating_vgws
  tags             = merge(var.tags, map("Name", format("%s-rt-elb", var.name)))
}

// Route tables (private)
resource "aws_route_table" "private" {
  vpc_id           = aws_vpc.mod.id
  propagating_vgws = var.private_propagating_vgws
  count            = length(var.azs)
  tags             = merge(var.tags, map("Name", format("%s-rt-private-%s", var.name, element(var.azs, count.index))))
}

resource "aws_route_table" "database" {
  vpc_id           = aws_vpc.mod.id
  propagating_vgws = var.private_propagating_vgws
  count            = length(var.azs)
  tags             = merge(var.tags, map("Name", format("%s-rt-database-%s", var.name, element(var.azs, count.index))))
}

resource "aws_route_table" "webapp" {
  vpc_id           = aws_vpc.mod.id
  propagating_vgws = var.private_propagating_vgws
  count            = length(var.azs)
  tags             = merge(var.tags, map("Name", format("%s-rt-webapp-%s", var.name, element(var.azs, count.index))))
}

resource "aws_route_table" "serverless" {
  vpc_id           = aws_vpc.mod.id
  propagating_vgws = var.private_propagating_vgws
  count            = length(var.azs)
  tags             = merge(var.tags, map("Name", format("%s-rt-serverless-%s", var.name, element(var.azs, count.index))))
}

//Subnets
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.mod.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = element(var.azs, count.index)
  count             = length(var.private_subnets)
  tags              = merge(var.tags, var.private_subnet_tags, map("Name", format("%s-private-subnet-%s", var.name, element(var.azs, count.index))))
}

resource "aws_subnet" "database" {
  vpc_id            = aws_vpc.mod.id
  cidr_block        = var.database_subnets[count.index]
  availability_zone = element(var.azs, count.index)
  count             = length(var.database_subnets)
  tags              = merge(var.tags, var.database_subnet_tags, map("Name", format("%s-database-subnet-%s", var.name, element(var.azs, count.index))))
}

resource "aws_db_subnet_group" "database" {
  name        = "${var.name}-rds-subnet-group"
  description = "Database subnet groups for ${var.name}"
  subnet_ids  = aws_subnet.database.*.id
  tags        = merge(var.tags, map("Name", format("%s-database-subnet-group", var.name)))
  count       = length(var.database_subnets) > 0 ? 1 : 0
}

resource "aws_subnet" "webapp" {
  vpc_id            = aws_vpc.mod.id
  cidr_block        = var.webapp_subnets[count.index]
  availability_zone = element(var.azs, count.index)
  count             = length(var.webapp_subnets)
  tags              = merge(var.tags, var.webapp_subnet_tags, map("Name", format("%s-webapp-subnet-%s", var.name, element(var.azs, count.index))))
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.mod.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = element(var.azs, count.index)
  count             = length(var.public_subnets)
  tags              = merge(var.tags, var.public_subnet_tags, map("Name", format("%s-public-subnet-%s", var.name, element(var.azs, count.index))))

  map_public_ip_on_launch = var.map_public_ip_on_launch
}

resource "aws_subnet" "elb" {
  vpc_id            = aws_vpc.mod.id
  cidr_block        = var.elb_subnets[count.index]
  availability_zone = element(var.azs, count.index)
  count             = length(var.elb_subnets)
  tags              = merge(var.tags, var.elb_subnet_tags, map("Name", format("%s-elb-subnet-%s", var.name, element(var.azs, count.index))))

  map_public_ip_on_launch = var.map_public_ip_on_launch
}

// Attaching route tables to subnets
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

resource "aws_route_table_association" "database" {
  count          = length(var.database_subnets)
  subnet_id      = element(aws_subnet.database.*.id, count.index)
  route_table_id = element(aws_route_table.database.*.id, count.index)
}

resource "aws_route_table_association" "webapp" {
  count          = length(var.webapp_subnets)
  subnet_id      = element(aws_subnet.webapp.*.id, count.index)
  route_table_id = element(aws_route_table.webapp.*.id, count.index)
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "elb" {
  count          = length(var.elb_subnets)
  subnet_id      = element(aws_subnet.elb.*.id, count.index)
  route_table_id = aws_route_table.elb.id
}

// Gateway association with route tables
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mod.id
}

resource "aws_route" "nat_internet_gateway" {
  route_table_id         = aws_route_table.nat.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mod.id
}

resource "aws_route" "elb_internet_gateway" {
  route_table_id         = aws_route_table.elb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mod.id
}
