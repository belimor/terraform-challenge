resource "aws_key_pair" "db_ssh_key" {
  key_name   = "db-ssh-key"
  public_key = file("${var.private_ssh_key}")

  tags = merge(
    var.custom_tags,
    {
      Name    = "private-ssh-key"
      Project = var.project
      Env     = var.env
    }
  )
}

resource "aws_security_group" "db_sg" {
  vpc_id      = aws_vpc.main.id
  name_prefix = "ssh-allow-"

  ingress {
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

  tags = merge(
    var.custom_tags,
    {
      Name    = "private-security-group"
      Project = var.project
      Env     = var.env
    }
  )
}

resource "random_integer" "private_subnet_selector" {
  min = 0
  max = 2
}

resource "aws_instance" "db_private_instance" {
  ami                    = var.private_ec2_ami
  instance_type          = var.private_ec2_type
  key_name               = aws_key_pair.db_ssh_key.key_name
  subnet_id              = aws_subnet.private[random_integer.private_subnet_selector.result].id
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  tags = merge(
    var.custom_tags,
    {
      Name    = "db-private-instance"
      Project = var.project
      Env     = var.env
    }
  )
}

