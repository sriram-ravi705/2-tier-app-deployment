output "private_ec2_ids" {
    value = [
        for instance in aws_instance.public_instance : instance.id
        if aws_instance.public_instance.public_ip == null
    ]
}