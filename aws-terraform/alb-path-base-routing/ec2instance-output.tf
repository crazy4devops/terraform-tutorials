output "ec2_bastion_public_instance_id" {
  description = "List of ID's of Instances"
  value       = module.ec2_public.id
}
output "ec2_bastion_public_ip" {
  description = "List of public IP name assigned to the instnaces"
  value       = module.ec2_public.public_ip

}

output "app1_ec2_private_instance_id" {
  description = "List of ID's of Instances"
  value       = module.ec2_private_app1.id
}
output "app1_ec2_private_ip" {
  description = "List of public IP name assigned to the instnaces"
  value       = module.ec2_private_app1.private_ip

}

output "app2_ec2_private_instance_id" {
  description = "List of ID's of Instances"
  value       = module.ec2_private_app2.id
}
output "app2_ec2_private_ip" {
  description = "List of public IP name assigned to the instnaces"
  value       = module.ec2_private_app2.private_ip

}