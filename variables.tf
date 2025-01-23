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
  description = "Depolyment environment"
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

variable "private_ec2_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "private_ec2_ami" {
  type        = string
  description = "AMI ID"
}

variable "private_ssh_key" {
  type        = string
  description = "Path to ssh key"
}

