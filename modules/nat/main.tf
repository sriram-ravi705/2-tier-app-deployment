resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = var.nat_gateway_eip
    subnet_id = var.nat_gateway_public_subnet
    tags = {
    "Name"=var.nat_gateway_name
  }
}