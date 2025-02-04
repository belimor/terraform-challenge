resource "aws_key_pair" "nginx_ssh_key" {
  key_name   = "nginx-ssh-key"
  public_key = file("${var.nginx_ssh_key}")

  tags = merge(
    var.custom_tags,
    {
      Name    = "nginx-ssh-key"
      Project = var.project
      Env     = var.env
    }
  )
}

resource "aws_security_group" "nginx_sg" {
  vpc_id      = aws_vpc.main.id
  name_prefix = "http-ssh-allow-"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.custom_tags,
    {
      Name    = "nginx-security-group"
      Project = var.project
      Env     = var.env
    }
  )
}

resource "random_integer" "nginx_subnet_selector" {
  min = 0
  max = 2
}

resource "aws_eip" "nginx_instance_eip" {
  domain   = "vpc"
  instance = aws_instance.nginx_public_instance.id

  tags = merge(
    var.custom_tags,
    {
      Name    = "nginx-instance-eip"
      Project = var.project
      Env     = var.env
    }
  )
}

resource "aws_instance" "nginx_public_instance" {
  ami                    = var.nginx_ec2_ami
  instance_type          = var.nginx_ec2_type
  key_name               = aws_key_pair.nginx_ssh_key.key_name
  subnet_id              = aws_subnet.public[random_integer.nginx_subnet_selector.result].id
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]

  tags = merge(
    var.custom_tags,
    {
      Name    = "nginx-public-instance"
      Project = var.project
      Env     = var.env
    }
  )
}

output "nginx_public_ip" {
  value       = aws_instance.nginx_public_instance.public_ip
  description = "The public IP address of the Nginx instance."
}

output "nginx_eip" {
  value = aws_eip.nginx_instance_eip.public_ip
}

