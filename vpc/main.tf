provider "aws" {
  region = var.region
  }

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = var.vpc_name
  

  cidr = var.vpc_cidr_block
  azs             = var.azs

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  database_subnets    = var.database_subnets

  enable_nat_gateway = true
  single_nat_gateway = true
  map_public_ip_on_launch = true

  tags = var.tags

}

