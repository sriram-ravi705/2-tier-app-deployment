output "entrypoint" {
  #value = aws_db_instance.db.endpoint
  value = replace(aws_db_instance.db.endpoint, "/:.*/", "")
}

output "username" {
  value = aws_db_instance.db.username
}

output "password" {
  value = aws_db_instance.db.password
}

output "dbname" {
  value = aws_db_instance.db.db_name
}