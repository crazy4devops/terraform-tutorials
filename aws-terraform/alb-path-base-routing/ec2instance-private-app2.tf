module "ec2_private_app2" {
  depends_on = [module.vpc]
  source     = "terraform-aws-modules/ec2-instance/aws"
  #version                = "~> 3.0"
  version       = "2.17.0"
  name          = "${var.environment}-app2"
  ami           = data.aws_ami.amzlinux.id
  instance_type = var.instance_type
  key_name      = var.instance_keypair
  vpc_security_group_ids = [module.private_sg.security_group_id]
  subnet_ids = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1]
  ]
  instance_count = var.private_instance_count
  user_data      = file("${path.module}/app2-install.sh")
  tags           = local.common_tags
}