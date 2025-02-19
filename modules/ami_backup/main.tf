resource "aws_ami_from_instance" "my_ami_backup" {
  source_instance_id = var.instance_id
  name = var.ami_name
  snapshot_without_reboot = "false"
}