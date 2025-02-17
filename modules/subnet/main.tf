data "aws_availability_zones" "available" {}

locals {
  azs = data.aws_availability_zones.available.names
  count_value = 0
}

resource "aws_subnet" "public_subnet" {
    count = length(var.public_subnet_cidr)
    vpc_id = var.vpc_id
    cidr_block = element(var.public_subnet_cidr,count.index)
    availability_zone = element(local.azs,count.index)
    tags = {
        Name = "${var.public_subnet_name}-${element(local.azs,count.index)}-${local.count_value+1}"
    }
}

resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet_cidr)
  vpc_id = var.vpc_id
  cidr_block = element(var.private_subnet_cidr,count.index)
  availability_zone = element(local.azs,count.index)
  tags = {
    Name =  "${var.private_subnet_name}-${element(local.azs,count.index)}-${local.count_value+1}"
  }
}

resource "aws_subnet" "private_db_subnet" {
  count = length(var.db_subnet_cidr)
  vpc_id = var.vpc_id
  cidr_block = element(var.db_subnet_cidr,count.index)
  availability_zone = element(local.azs,count.index)
  tags = {
    Name =  "${var.db_subnet_name}-${element(local.azs,count.index)}-${local.count_value+1}"
  }
}