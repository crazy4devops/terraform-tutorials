module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "6.4.0"
  # insert the 4 required variables here
  name               = "${local.name}-alb"
  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1]
  ]
  security_groups = [
    module.lb_sg.security_group_id
  ]

  #Listeners
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    },
    {
      port               = 81
      protocol           = "HTTP"
      target_group_index = 0
    },
  ]

  #Target groups
  target_groups = [
    {
      name_prefix          = "app1-"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      targets = {
        my_app1_vm1 = {
          target_id = module.ec2_private.id[0]
          port      = 80
        },
        my_app1_vm2 = {
          target_id = module.ec2_private.id[1]
          port      = 80
        },
        my_app1_vm3 = {
          target_id = module.ec2_private.id[2]
          port      = 80
        },
        my_app1_vm4 = {
          target_id = module.ec2_private.id[3]
          port      = 80
        },
        my_app1_vm5 = {
          target_id = module.ec2_private.id[4]
          port      = 80
        },
      }
      tags = local.common_tags
    }
  ]

  tags = local.common_tags
}