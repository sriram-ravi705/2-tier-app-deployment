resource "aws_route_table" "public_route" {
  vpc_id = var.vpc_id

  route {
    gateway_id = var.internet_gateway
    cidr_block = var.gateway_cidr_block
  }

  tags = {
    "Name"=var.public_route_name
  }
}

resource "aws_route_table_association" "route_table_association" {
    count = length(var.public_subnets)
    subnet_id = element(var.public_subnets,count.index)
    route_table_id = aws_route_table.public_route.id
}