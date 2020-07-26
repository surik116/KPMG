resource "aws_security_group" "bastion_sg" {
  name = "${terraform.workspace}-bastion-sg"
  description = "Bastion Security Group"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  tags = {
    Name = "${terraform.workspace}-bastion-sg"
  }

  ingress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    self = true
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["12.13.203.75/32"] // SSH access restricted by IP address
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
