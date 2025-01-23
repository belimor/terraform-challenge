
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr    = var.vpc_cidr
  custom_tags = var.custom_tags
  project     = var.project
  env         = var.env
}

module "nginx" {
  source = "./modules/ec2-public"

  name                 = "nginx"
  custom_tags          = var.custom_tags
  project              = var.project
  env                  = var.env
  ec2_type             = var.nginx_ec2_type
  ec2_ami              = var.nginx_ec2_ami
  ssh_key              = var.nginx_ssh_key
  vpc_id               = module.vpc.vpc_id
  subnet_ids           = module.vpc.public_subnet_ids
  security_group_rules = var.nginx_security_group_rules
}

module "bastion" {
  source = "./modules/ec2-public"

  name                 = "bastion"
  custom_tags          = var.custom_tags
  project              = var.project
  env                  = var.env
  ec2_type             = var.bastion_ec2_type
  ec2_ami              = var.bastion_ec2_ami
  ssh_key              = var.bastion_ssh_key
  vpc_id               = module.vpc.vpc_id
  subnet_ids           = module.vpc.public_subnet_ids
  security_group_rules = var.bastion_security_group_rules
}
