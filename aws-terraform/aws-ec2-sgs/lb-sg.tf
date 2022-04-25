module "lb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"
  # insert the 3 required variables here
  name   = "lb-sg"
  vpc_id = module.vpc.vpc_id

  #egress rules
  egress_rules = ["all-all"]

  #ingress 
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"]
  tags                = local.common_tags
  ingress_with_cidr_blocks = [
    {
      from_port   = 81
      to_port     = 81
      protocol    = 6
      description = "Allow 81 traffice from internet"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}