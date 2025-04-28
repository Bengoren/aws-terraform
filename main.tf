provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "ssh_access" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0c94855ba95c71c99"  # Ubuntu Server 22.04
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  tags = {
    Name = "Terraform-DevOps-Instance"
    Environment = "Development"
  }
}
