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

variable "vpc_cidr" {
  type        = string
  description = "VCP CIDR"
  default     = "10.0.0.0/16"
}

