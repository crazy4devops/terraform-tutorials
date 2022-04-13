

output "for_output_list" {
    description = "for loop with list"
    value = [ for instance in aws_instance.dev-ec2: instance.public_ip]
  
}

output "for_output_map" {
    description = "for loop with Map"
    value = {for instance in aws_instance.dev-ec2: instance.id => instance.public_dns}
  
}

output "for_output_map2" {
    description = "for loop with Map - Advanced"
    value = {for c, instance in aws_instance.dev-ec2: c => instance.public_dns }
}

output "legacy_splat_operator" {
    description = "legacy spalt operator with public_dns"
    value = aws_instance.dev-ec2.*.public_dns
  
}
output "latest_spalt_operator" {
    description = "latest spalt operator with public_dns"
    value = aws_instance.dev-ec2[*].public_dns
  
}