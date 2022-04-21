output "ec2_bastion_public_instance_id" {
  description = "List of ID's of Instances"
  value       = module.ec2_public.id
}
output "ec2_bastion_public_ip" {
  description = "List of public IP name assigned to the instnaces"
  value       = module.ec2_public.public_ip

}

output "ec2_private_instance_id" {
  description = "List of ID's of Instances"
  value       = module.ec2_private.id
}
output "ec2_private_ip" {
  description = "List of public IP name assigned to the instnaces"
  value       = module.ec2_private.private_ip

}