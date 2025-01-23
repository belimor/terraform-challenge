resource "aws_key_pair" "ec2_public" {
  key_name   = "${var.name}-ssh-key"
  public_key = file("${var.ssh_key}")

  tags = merge(
    var.custom_tags,
    {
      Name    = "${var.name}-ssh-key"
      Project = var.project
      Env     = var.env
    }
  )
}

resource "aws_security_group" "ec2_public" {
  vpc_id      = var.vpc_id
  name_prefix = "${var.name}-sg"

  tags = merge(
    var.custom_tags,
    {
      Name    = "${var.name}-security-group"
      Project = var.project
      Env     = var.env
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "ec2_public" {
  for_each          = var.security_group_rules.ingress
  security_group_id = aws_security_group.ec2_public.id
  cidr_ipv4         = each.value.cidr_ipv4
  from_port         = each.value.from_port
  ip_protocol       = each.value.ip_protocol
  to_port           = each.value.to_port
}

resource "aws_vpc_security_group_egress_rule" "ec2_public" {
  for_each          = var.security_group_rules.egress
  security_group_id = aws_security_group.ec2_public.id
  cidr_ipv4         = each.value.cidr_ipv4
  from_port         = each.value.from_port
  ip_protocol       = each.value.ip_protocol
  to_port           = each.value.to_port
}

resource "aws_eip" "ec2_public" {
  domain   = "vpc"
  instance = aws_instance.ec2_public.id

  tags = merge(
    var.custom_tags,
    {
      Name    = "${var.name}-instance-eip"
      Project = var.project
      Env     = var.env
    }
  )
}

resource "random_integer" "selector" {
  min = 0
  max = 2
}

resource "aws_instance" "ec2_public" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_type
  key_name               = aws_key_pair.ec2_public.key_name
  subnet_id              = var.subnet_ids[random_integer.selector.result]
  vpc_security_group_ids = [aws_security_group.ec2_public.id]

  tags = merge(
    var.custom_tags,
    {
      Name    = "${var.name}-public-instance"
      Project = var.project
      Env     = var.env
    }
  )
}


