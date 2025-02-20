

resource "aws_autoscaling_group" "ag" {
  desired_capacity = 2
  min_size = 1
  max_size = 3
  vpc_zone_identifier = var.subnet_ids
  launch_template {
    id = var.launch_template_id
    version = "$Latest"
  }
  target_group_arns = var.target_group_arns
  tag {
    key = "Name"
    value = var.ag_name
    propagate_at_launch = false
  }
  
}