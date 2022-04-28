module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr_block

  azs             = var.vpc_availability_zone
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  # create_database_subnet_group       = var.vpc_create_database_subnet_group
  # create_database_subnet_route_table = var.vpc_create_database_subnet_route_table
  # database_subnets                   = var.vpc_database_subnets
  # create_database_nat_gateway_route  = true

  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags     = local.common_tags
  vpc_tags = local.common_tags

  public_subnet_tags = {
    Name = "Public Subnets"
  }
  private_subnet_tags = {
    Name = "Private Subnets"
  }
  database_subnet_tags = {
    Name = "database Subnets"
  }
}
