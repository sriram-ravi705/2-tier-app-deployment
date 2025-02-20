output "public_ip" {
  value=[aws_instance.instance.id]
}