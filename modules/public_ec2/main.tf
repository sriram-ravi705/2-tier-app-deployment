resource "aws_instance" "instance" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet
  security_groups = var.sg
  associate_public_ip_address = var.public_ip
  key_name = "terraform_key"
  tags = {
    "Name"=var.instance_name
  }
}