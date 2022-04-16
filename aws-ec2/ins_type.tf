data "aws_ec2_instance_type_offerings" "instance_type_offering" {
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
    #values = ["t3.micro"]
  }

  filter {
    name   = "location"
    values = ["us-east-1e"]
  }

  location_type = "availability-zone"
}

output "get_instance_location" {
  description = "check ec2 type offerings"
  value       = data.aws_ec2_instance_type_offerings.instance_type_offering.locations

}