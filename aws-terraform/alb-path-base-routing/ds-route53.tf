data "aws_route53_zone" "mydomain" {
  name = "teachdevops.in"
}

output "mydomain_id" {
    description = " The Hosted Zone ID. This can be referenced by zone records"
    value = data.aws_route53_zone.mydomain.zone_id
  
}

output "mydomain_name" {
    description = "This is the name of the hosted zone"
    value = data.aws_route53_zone.mydomain.name
  
}