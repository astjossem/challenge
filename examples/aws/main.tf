provider "aws" {
  region = var.region
}

module "ssh" {
  source = "../../modules/aws/ssh"
}

module "security_group" {
  source = "../../modules/aws/security-group"

  ssh_access = var.ssh_access
}

module "aws-compute" {
  source = "../../modules/aws/compute"

  instance_count     = var.instance_count
  ssh_access         = var.ssh_access
  key_name           = module.ssh.ssh_key_name
  private_key_pem    = module.ssh.private_key_pem
  security_group_ids = [module.security_group.sg_id]
}