aws_region = "us-east-2"
project    = "Ansys"
env        = "dev"

custom_tags = {
  owner    = "Dmitry"
}

vpc_cidr       = "10.0.0.0/16"

nginx_ec2_type = "t2.micro"
nginx_ec2_ami  = "ami-0cb91c7de36eed2cb"
nginx_ssh_key  = "~/.ssh/id_ed25519.pub"

bastion_ec2_type = "t2.micro"
bastion_ec2_ami  = "ami-0cb91c7de36eed2cb"
bastion_ssh_key  = "~/.ssh/id_ed25519.pub"

private_ec2_type = "t2.micro"
private_ec2_ami  = "ami-0cb91c7de36eed2cb"
private_ssh_key  = "~/.ssh/id_ed25519.pub"
