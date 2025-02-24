resource "aws_instance" "instance" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet
  security_groups = var.sg
  associate_public_ip_address = var.public_ip
  key_name = "terraform_key"
  user_data = <<-EOT
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y curl
              curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
              sudo apt install -y nodejs
              cd /home/ubuntu
              git clone "https://github.com/sriram-ravi705/Taskify.git"
              cd /home/ubuntu/Taskify
              sudo npm install
              echo "DB_HOST=${var.endpoint}" > /home/ubuntu/Taskify/.env
              echo "DB_USER=${var.db_user}" >> /home/ubuntu/Taskify/.env
              echo "DB_PASSWORD=${var.db_password}" >> /home/ubuntu/Taskify/.env
              echo "DB_NAME=${var.db_name}" >> /home/ubuntu/Taskify/.env
              pm2 startup systemd
              pm2 save
              sudo npm start &
              EOT
  tags = {
    "Name"=var.instance_name
    "Terraform"="Terraform_Instance"
  }
}