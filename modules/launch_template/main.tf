resource "aws_launch_template" "aws_template" {
  name = var.launch_template_name
  image_id = var.image_id
  #vpc_security_group_ids = var.sg
  key_name = "ansible_key"
  instance_type = var.instance_type
  network_interfaces {
    associate_public_ip_address = "true"
    security_groups = var.sg
  }
  user_data = filebase64("${path.module}/user_data.sh")   
  tags = {
    "Terraform"="Terraform_Instance"
  }
}