resource "aws_lb_target_group" "lb_target_group" {
  protocol = "HTTP"
  port = 80
  vpc_id = var.vpc_id

  tags = {
    Name = "target_group"
  }
}

resource "aws_lb_target_group_attachment" "target_group_1" {
    count = length(var.ec2)
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    target_id = element(var.ec2,count.index)
    port = 80
}