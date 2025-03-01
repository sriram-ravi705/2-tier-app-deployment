output "public_ip" {
  value=aws_instance.instance.id
}

# output "null_reousrce_id"{
#   value = null_resource.configure_ansible.id
# }