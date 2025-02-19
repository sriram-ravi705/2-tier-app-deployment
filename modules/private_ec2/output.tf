output "private_ip" {
  value=[aws_instance.private_instance.id]
}