variable "name" {
  type        = string
  description = "EC2 name"
}

variable "project" {
  type        = string
  description = "Project name"
}

variable "env" {
  type        = string
  description = "Depolyment environment"
}

variable "custom_tags" {
  type        = map(string)
  description = "Custom tags"
}

variable "ec2_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ec2_ami" {
  type        = string
  description = "AMI ID"
}

variable "ssh_key" {
  type        = string
  description = "Path to ssh key"
}

variable "vpc_id" {
  type        = string
  description = "VPC id"
}

variable "subnet_ids" {
  type        = list(any)
  description = "List of subnet ids"
}

variable "security_group_rules" {
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
