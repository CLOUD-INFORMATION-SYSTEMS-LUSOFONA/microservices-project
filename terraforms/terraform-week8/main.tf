terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.common_tags
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

locals {
  workspace_name = terraform.workspace == "default" ? "dev" : terraform.workspace

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = local.workspace_name
      ManagedBy   = "Terraform"
      Workspace   = terraform.workspace
      Week        = "8"
    },
    var.additional_tags
  )
}

module "network" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  tags                 = local.common_tags
}

module "compute" {
  source              = "./modules/ec2"
  vpc_id              = module.network.vpc_id
  subnet_id           = module.network.public_subnet_ids[0]
  ami_id              = data.aws_ami.amazon_linux.id
  instance_type       = var.instance_type
  key_name            = var.key_name
  allowed_ports       = var.allowed_ports
  allowed_cidr_blocks = var.allowed_cidr_blocks
  user_data           = var.ec2_user_data
  tags                = local.common_tags
}

module "database" {
  source                     = "./modules/rds"
  vpc_id                     = module.network.vpc_id
  subnet_ids                 = module.network.private_subnet_ids
  allowed_security_group_ids = [module.compute.security_group_id]
  db_name                    = var.db_name
  username                   = var.db_username
  password                   = var.db_password
  instance_class             = var.db_instance_class
  engine                     = var.db_engine
  engine_version             = var.db_engine_version
  port                       = var.db_port
  tags                       = local.common_tags
}

