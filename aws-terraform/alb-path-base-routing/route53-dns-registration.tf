resource "aws_route53_record" "mydns_record" {
  zone_id = data.aws_route53_zone.mydomain.zone_id
  name    = "app.teachdevops.in"
  type    = "A"

  alias {
    name                   = module.alb.lb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = true
  }
}