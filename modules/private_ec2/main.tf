resource "aws_instance" "private_instance" {
  ami = var.private_ami
  instance_type = var.private_instance_type
  subnet_id = var.private_subnet
  security_groups = var.private_sg
  associate_public_ip_address = var.private_public_ip
  key_name = "terraform_key"
  tags = {
    "Name"=var.instance_name
  }
}