module "elb" {
  source  = "terraform-aws-modules/elb/aws"
  version = "~> 2.0"

  name = "${local.name}-myelb"

  subnets = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1]
  ]
  security_groups = [module.lb_sg.security_group_id]

  listener = [
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 80
      lb_protocol       = "HTTP"
    },
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 81
      lb_protocol       = "HTTP"
    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  // ELB attachments
  number_of_instances = var.private_instance_count
  # count               = var.private_instance_count
  instances = [
    module.ec2_private.id[0],
    module.ec2_private.id[1],
    module.ec2_private.id[2],
    module.ec2_private.id[3],
    module.ec2_private.id[4],
  ]

  tags = local.common_tags
}