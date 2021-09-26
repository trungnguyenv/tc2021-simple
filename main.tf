terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.59.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.region

  default_tags {
    tags = {
      Environment = var.environment
    }
  }
}

module "iam" {
  source = "./iam"

  environment         = var.environment
  deployer_public_key = file("~/.ssh/id_rsa.pub")
}

module "network" {
  source = "./network"

  environment          = var.environment
  base_cidr            = var.base_cidr
  ssh_source_whitelist = var.ssh_source_whitelist
}

module "ec2" {
  source = "./ec2"

  environment       = var.environment
  deployer_key_name = module.iam.deployer_key_name
  public_subnet_id  = module.network.public_subnet_id
  security_groups = [
    module.network.default_security_group_id,
    module.network.www_security_group_id,
    module.network.private_access_security_group_id
  ]
}
