module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "3.4.1"
  domain_name  = trimsuffix(data.aws_route53_zone.mydomain.name,".")
  zone_id      =  data.aws_route53_zone.mydomain.zone_id

  subject_alternative_names = [
    "*.teachdevops.in"
  ]

  tags = local.common_tags
}

output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = module.acm.acm_certificate_arn
}