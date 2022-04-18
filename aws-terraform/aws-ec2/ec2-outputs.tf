
# output "latest_spalt_operator" {
#   description = "latest spalt operator with public_dns"
#   value       = aws_instance.dev-ec2[*].public_dns

# }

# output "latest_spalt_operator" {
#   description = "latest spalt operator with public_dns"
#   value       = toset(aws_instance.dev-ec2[*].public_dns)

# }

output "instance_publicip" {
  description = "get all public IP's"
  value       = toset([for instance in aws_instance.dev-ec2 : instance.public_ip])

}

output "instance_publicdns" {
  description = "get all public DNS"
  value       = toset([for instance in aws_instance.dev-ec2 : instance.public_dns])

}

output "instance_publicdnsmap" {

  value = { for az, instance in aws_instance.dev-ec2 : az => instance.public_dns }

}