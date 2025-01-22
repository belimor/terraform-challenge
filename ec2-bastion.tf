resource "aws_key_pair" "bastion_ssh_key" {
  key_name   = "bastion-ssh-key"
  public_key = file("~/.ssh/id_ed25519.pub")
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
}

resource "random_integer" "bastion_subnet_selector" {
  min = 0
  max = 2
}

resource "aws_instance" "bastion_public_instance" {
  ami                         = "ami-0cb91c7de36eed2cb" 
  instance_type               = "t2.micro"              
  key_name                    = aws_key_pair.bastion_ssh_key.key_name
  subnet_id                   = aws_subnet.public[random_integer.bastion_subnet_selector.result].id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "bastion-public-instance"
  }
}

output "bastion_public_ip" {
  value       = aws_instance.bastion_public_instance.public_ip
  description = "The public IP address of the Bastion instance."
}

