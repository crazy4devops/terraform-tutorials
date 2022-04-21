module "ec2_private" {
  depends_on = [module.vpc]
  source     = "terraform-aws-modules/ec2-instance/aws"
  #version                = "~> 3.0"
  version       = "2.17.0"
  name          = "${var.environment}-vm"
  ami           = data.aws_ami.amzlinux.id
  instance_type = var.instance_type
  key_name      = var.instance_keypair
  #vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  vpc_security_group_ids = [module.private_sg.security_group_id]
  #module.private_sg.security_group_id
  #count                  = length(var.vpc_private_subnets)
  #subnet_id              = module.vpc.private_subnets[count.index]

  subnet_ids = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1]
  ]
  instance_count = var.private_instance_count
  user_data      = file("${path.module}/install-web.sh")
  tags           = local.common_tags
}