variable "project" {
  type        = string
  description = "Project name"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "env" {
  type        = string
  description = "Deployment environment"
}

variable "custom_tags" {
  type        = map(string)
  description = "Custom tags"
}

variable "vpc_cidr" {
  type        = string
  description = "VCP CIDR"
  default     = "10.0.0.0/16"
}

variable "nginx_ec2_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "nginx_ec2_ami" {
  type        = string
  description = "AMI ID"
}

variable "nginx_ssh_key" {
  type        = string
  description = "Path to ssh key"
}

variable "bastion_ec2_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "bastion_ec2_ami" {
  type        = string
  description = "AMI ID"
}

variable "bastion_ssh_key" {
  type        = string
  description = "Path to ssh key"
}

variable "nginx_security_group_rules" {
  description = "The security group rules for the web servers."
  type = object({
    ingress = optional(map(object({
      cidr_ipv4   = string
      from_port   = number
      ip_protocol = string
      to_port     = number
    })), {})
    egress = optional(map(object({
      cidr_ipv4   = string
      from_port   = number
      ip_protocol = string
      to_port     = number
    })), {})
  })
}

variable "bastion_security_group_rules" {
  description = "The security group rules for the web servers."
  type = object({
    ingress = optional(map(object({
      cidr_ipv4   = string
      from_port   = number
      ip_protocol = string
      to_port     = number
    })), {})
    egress = optional(map(object({
      cidr_ipv4   = string
      from_port   = number
      ip_protocol = string
      to_port     = number
    })), {})
  })
}

