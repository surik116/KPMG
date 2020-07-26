data "aws_ami" "aws_linux" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn-ami-hvm*"]
  }

  filter {
    name = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }

}

resource "aws_instance" "bastion" {
  ami = data.aws_ami.aws_linux.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  iam_instance_profile = aws_iam_instance_profile.bastion_profile.id
  associate_public_ip_address = true
  key_name = "vyomadaily-${terraform.workspace}-bastion"
  subnet_id = data.terraform_remote_state.vpc.outputs.public_subnets[0]

  root_block_device {
    delete_on_termination = true
    volume_size = 8
    volume_type = "gp2"
  }

  tags = {
    Name = "${terraform.workspace}-Bastion"
  }
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name  = "bastion-profile"
  role = aws_iam_role.bastion_role.name
}
