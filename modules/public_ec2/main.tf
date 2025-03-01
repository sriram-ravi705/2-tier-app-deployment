resource "aws_instance" "instance" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet
  security_groups = var.sg
  associate_public_ip_address = var.public_ip
  key_name = "ansible_key"
  user_data = filebase64("${path.module}/user_data.sh")
  tags = {
    "Name"=var.instance_name
    "Terraform"="Terraform_Instance"
  }
  provisioner "file" {
    source = "${path.module}/private_key.pem"
    destination = "/home/ubuntu/ansible_key.pem"
  }
  connection {
      host        = aws_instance.instance.public_ip
      user        = "ubuntu"
      private_key = file("${path.module}/private_key.pem")
      type        = "ssh"
  }
  provisioner "remote-exec" {
    connection {
      host        = aws_instance.instance.public_ip
      user        = "ubuntu"
      private_key = file("${path.module}/private_key.pem")
      type        = "ssh"
    }
    
    inline = [
        "sudo apt update",
        "sudo apt install software-properties-common",
        "sudo add-apt-repository --yes --update ppa:ansible/ansible",
        "sudo apt install ansible -y",
        "sudo chmod 400 /home/ubuntu/ansible_key.pem",
        "sudo echo '[defaults]' > /home/ubuntu/ansible.cfg",
        "sudo echo 'host_key_checking = False' >> /home/ubuntu/ansible.cfg",
        "touch /home/ubuntu/new_hosts",
        "sudo echo '${aws_instance.instance.private_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/ansible_key.pem' >> /home/ubuntu/new_hosts",
        "echo '${file("${path.module}/Deployment.yaml")}' > /home/ubuntu/Deployment.yaml",
        "ansible-playbook -i new_hosts Deployment.yaml",
        "sudo chmod 777 /home/ubuntu/Taskify",
        "echo 'DB_HOST=${var.endpoint}' > /home/ubuntu/Taskify/.env",
        "echo 'DB_USER=${var.db_user}' >> /home/ubuntu/Taskify/.env",
        "echo 'DB_PASSWORD=${var.db_password}' >> /home/ubuntu/Taskify/.env",
        "echo 'DB_NAME=${var.db_name}' >> /home/ubuntu/Taskify/.env",
        # "sudo chmod 600 /home/ubuntu/Taskify/.env",
        "pm2 start /home/ubuntu/Taskify/index.js --name nodejs"
    ]
  }
}


# resource "null_resource" "configure_ansible" {
 
# }
