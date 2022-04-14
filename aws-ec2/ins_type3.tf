
data "aws_ec2_instance_type_offerings" "ins_type3" {
  for_each = toset(data.aws_availability_zones.my_azs.names)
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }

  filter {
    name   = "location"
    values = [each.key]
  }

  location_type = "availability-zone"
}


output "type_v3" {
  description = "check ec2 type"
  value = { for type, t in data.aws_ec2_instance_type_offerings.ins_type3: type => t.instance_types}
  
}


output "type_v4" {
  description = "check ec2 type"
  value = { for type, t in data.aws_ec2_instance_type_offerings.ins_type3: 
  type => t.instance_types if length(t.instance_types) != 0}
  
}
output "type_v5" {
  description = "check ec2 type"
  value = keys ({ for type, t in data.aws_ec2_instance_type_offerings.ins_type3: 
  type => t.instance_types if length(t.instance_types) != 0})
  
}

output "type_v6" {
  description = "check ec2 type"
  value = keys ({ for type, t in data.aws_ec2_instance_type_offerings.ins_type3: 
  type => t.instance_types if length(t.instance_types) != 0})[0]
  
}