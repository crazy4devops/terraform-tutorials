module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"
  # insert the 3 required variables here
  name   = "private-sg"
  vpc_id = module.vpc.vpc_id

  #egress rules
  egress_rules = ["all-all"]


  #ingress 
  ingress_cidr_blocks = [var.vpc_cidr_block]
  ingress_rules       = ["ssh-tcp", "http-80-tcp"]

  tags = local.common_tags
}