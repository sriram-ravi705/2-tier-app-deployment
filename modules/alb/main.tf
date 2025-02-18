resource "aws_lb" "lb" {
    security_groups = var.security_groups
    subnets = var.subnets
    tags = {
        Name = "aws_lb"
    }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = var.target_group_arn
  }
}