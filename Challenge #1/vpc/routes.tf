
// S3 endpoint route to private route table
resource "aws_vpc_endpoint_route_table_association" "private_s3_route" {
  count = length(module.vpc.private_route_table_ids)
  //  count = "2"
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
  route_table_id = module.vpc.private_route_table_ids[count.index]
}

// DynamoDB enpoint route to private route table
resource "aws_vpc_endpoint_route_table_association" "private_dynamodb_route" {
  count = length(module.vpc.private_route_table_ids)
  //  count = "2"
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb_endpoint.id
  route_table_id = module.vpc.private_route_table_ids[count.index]
}

// S3 endpoint route to webapp route table
resource "aws_vpc_endpoint_route_table_association" "webapp_s3_route" {
  count = length(module.vpc.webapp_route_table_ids)
  //  count = "2"
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
  route_table_id = module.vpc.webapp_route_table_ids[count.index]
}
