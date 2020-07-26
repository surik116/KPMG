output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "bastion_sg_name" {
  value = aws_security_group.bastion_sg.name
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}
