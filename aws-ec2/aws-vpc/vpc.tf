module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "dev-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"] 
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"] 

  create_database_subnet_group       = true
  create_database_subnet_route_table = true
  database_subnets                   = ["10.0.5.0/24", "10.0.6.0/24"]
  create_database_nat_gateway_route = true

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true


  public_subnet_tags = {
    Name = "Public Subnets"
  }
  private_subnet_tags = {
    Name = "Private Subnets"
  }
  database_subnet_tags = {
    Name = "database Subnets"
  }
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
