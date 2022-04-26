module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"
  # insert the 3 required variables here
  name   = "public-bastion-sg"
  vpc_id = module.vpc.vpc_id

  #egress rules
  egress_rules = ["all-all"]


  #ingress 
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]

  tags = local.common_tags
}