output "web_sg" {
  value = aws_security_group.web_sg.id
}

output "app_sg" {
  value = aws_security_group.app_sg.id
}