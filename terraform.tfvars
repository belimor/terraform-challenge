aws_region = "us-east-2"
project    = "Ansys"
env        = "dev"

custom_tags = {
  Owner = "Dmitry"
}

vpc_cidr = "10.0.0.0/16"

nginx_ec2_type = "t2.micro"
nginx_ec2_ami  = "ami-0cb91c7de36eed2cb"
nginx_ssh_key  = "~/.ssh/id_ed25519.pub"

bastion_ec2_type = "t2.micro"
bastion_ec2_ami  = "ami-0cb91c7de36eed2cb"
bastion_ssh_key  = "~/.ssh/id_ed25519.pub"

nginx_security_group_rules = {
  ingress = {
    "http-public-subnet" = {
      cidr_ipv4   = "0.0.0.0/0"
      from_port   = 80
      ip_protocol = "tcp"
      to_port     = 80
    }
    "ssh-public-subnet" = {
      cidr_ipv4   = "10.0.0.0/16"
      from_port   = 22
      ip_protocol = "tcp"
      to_port     = 22
    }
  }
  egress = {
    "all" = {
      cidr_ipv4   = "0.0.0.0/0"
      from_port   = -1
      ip_protocol = -1
      to_port     = -1
    }
  }
}

bastion_security_group_rules = {
  ingress = {
    "ssh-public-subnet" = {
      cidr_ipv4   = "0.0.0.0/0"
      from_port   = 22
      ip_protocol = "tcp"
      to_port     = 22
    }
  }
  egress = {
    "all" = {
      cidr_ipv4   = "0.0.0.0/0"
      from_port   = -1
      ip_protocol = -1
      to_port     = -1
    }
  }
}

