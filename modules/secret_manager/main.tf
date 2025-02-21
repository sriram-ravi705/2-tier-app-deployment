resource "aws_secretsmanager_secret" "secret_manager" {
  tags = {
    Name = "screate_manager"
  }
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id = aws_secretsmanager_secret.secret_manager.id
  secret_string = jsonencode({
    username = var.username
    password = var.password
  })
}