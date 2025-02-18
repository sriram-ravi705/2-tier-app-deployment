resource "aws_security_group" "web_sg" {
  vpc_id = var.vpc_id
  tags = {
    "Name"="web ${var.sg_name}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
  security_group_id = aws_security_group.web_sg.id
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
  security_group_id = aws_security_group.web_sg.id
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  to_port = 443
  ip_protocol = "tcp"
  security_group_id = aws_security_group.web_sg.id
}

resource "aws_vpc_security_group_ingress_rule" "mysql" {
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 3306
  to_port = 3306
  ip_protocol = "tcp"
  security_group_id = aws_security_group.web_sg.id
}

resource "aws_vpc_security_group_egress_rule" "all_traffic" {
  security_group_id = aws_security_group.web_sg.id
  ip_protocol = -1
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_security_group" "app_sg" {
  vpc_id = var.vpc_id
  tags = {
    "Name"="app ${var.sg_name}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "all_traffic_from_parent_host" {
    security_group_id = aws_security_group.app_sg.id
    ip_protocol = -1
    referenced_security_group_id = aws_security_group.web_sg.id
}


resource "aws_vpc_security_group_egress_rule" "all_traffic_outbount" {
  security_group_id = aws_security_group.app_sg.id
  ip_protocol = -1
  cidr_ipv4 = "0.0.0.0/0"
}

