resource "aws_db_subnet_group" "db_subnet" {
  name = var.db_sub_name
  subnet_ids = var.private_subnets
}

resource "aws_db_instance" "db" {
  identifier = "instance"
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.r7g.large"
  allocated_storage = 20
  username = var.db_username
  password = var.password
  db_name = var.db_name
  vpc_security_group_ids = var.sg
  db_subnet_group_name = aws_db_subnet_group.db_subnet.id
  skip_final_snapshot = true
  tags = {
    "Name"=var.db_sub_name
  }
}