resource "aws_key_pair" "bastion_ssh_key" {
  key_name   = "bastion-ssh-key"
  public_key = file("${var.bastion_ssh_key}")

  tags = merge(
    var.custom_tags,
    {
      Name    = "bastion-ssh-key"
      Project = var.project
      Env     = var.env
    }
  )
}

resource "aws_security_group" "bastion_sg" {
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
      Name    = "bastion-security-group"
      Project = var.project
      Env     = var.env
    }
  )
}

resource "random_integer" "bastion_subnet_selector" {
  min = 0
  max = 2
}

resource "aws_instance" "bastion_public_instance" {
  ami                         = var.bastion_ec2_ami
  instance_type               = var.bastion_ec2_type
  key_name                    = aws_key_pair.bastion_ssh_key.key_name
  subnet_id                   = aws_subnet.public[random_integer.bastion_subnet_selector.result].id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]

  tags = merge(
    var.custom_tags,
    {
      Name    = "bastion-public-instance"
      Project = var.project
      Env     = var.env
    }
  )
}

output "bastion_public_ip" {
  value       = aws_instance.bastion_public_instance.public_ip
  description = "The public IP address of the Bastion instance."
}

