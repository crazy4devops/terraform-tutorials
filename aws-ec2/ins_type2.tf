data "aws_ec2_instance_type_offerings" "ins_type2" {
  for_each = toset ([ "us-east-1a","us-east-1b","us-east-1e" ])

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

output "type_v1" {
  description = "check ec2 type"
  value = [for t in data.aws_ec2_instance_type_offerings.ins_type2: t.instance_types]
  
}
output "type_v2" {
  description = "check ec2 type"
  value = { for type, t in data.aws_ec2_instance_type_offerings.ins_type2: type => t.instance_types}
  
}