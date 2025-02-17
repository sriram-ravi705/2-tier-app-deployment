module "vpc" {
  source         = "./modules/vpc"
  vpc_name       = "${var.environment} my-vpc"
  vpc_cidr_block = var.vpc_cidr_block
}

module "ig" {
  source                    = "./modules/ig"
  vpc_id                    = module.vpc.vpc_id
  aws_internet_gateway_name = "internet_gateway_terra"
}

module "subnets" {
  source              = "./modules/subnet"
  vpc_id              = module.vpc.vpc_id
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  db_subnet_cidr      = var.db_subnet_cidr
  public_subnet_name  = "${var.environment} Web Subnet"
  private_subnet_name = "${var.environment} App Subnet"
  db_subnet_name      = "${var.environment} DB Subnet"
}

module "public_route_table" {
  source             = "./modules/route_table"
  vpc_id             = module.vpc.vpc_id
  internet_gateway   = module.ig.ig_id
  gateway_cidr_block = var.public_source_gateway_cidr_block
  public_route_name  = "${var.environment} public_router"
  public_subnets     = [module.subnets.public_subnet_ids[0], module.subnets.public_subnet_ids[1]]
}

module "eip" {
  source   = "./modules/eip"
  eip_name = "nat_eip"
}

module "nat" {
  source                    = "./modules/nat"
  nat_gateway_eip           = module.eip.nat_eip
  nat_gateway_name          = "${var.environment} private_nat_gateway"
  nat_gateway_public_subnet = module.subnets.public_subnet_ids[0]
}

module "private_route_table" {
  source             = "./modules/route_table"
  vpc_id             = module.vpc.vpc_id
  internet_gateway   = module.nat.nat_gat_id
  gateway_cidr_block = var.private_source_gateway_cidr_block
  public_route_name  = "${var.environment} private_router"
  public_subnets     = [module.subnets.private_subnet_ids[0], module.subnets.private_subnet_ids[1]]
}

module "sg" {
  source  = "./modules/sg"
  vpc_id  = module.vpc.vpc_id
  sg_name = "security group"
}

module "public_ec2" {
  source        = "./modules/ec2"
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
  subnet        = module.subnets.public_subnet_ids[0]
  sg            = [module.sg.web_sg]
  public_ip     = "true"
  instance_name = "web_app"
}

module "private_ec2" {
  source        = "./modules/ec2"
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
  subnet        = module.subnets.private_subnet_ids[0]
  sg            = [module.sg.app_sg]
  public_ip     = "false"
  instance_name = "app"
}
