output "username" {
    value = jsondecode(aws_secretsmanager_secret_version.secret_version.secret_string)["username"]
}

output "password" {
    value = jsondecode(aws_secretsmanager_secret_version.secret_version.secret_string)["password"]
}