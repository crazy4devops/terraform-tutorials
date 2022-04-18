resource "aws_instance" "dev-ec2" {
  ami = data.aws_ami.amzlinux.id
  #instance_type = var.instance_type
  instance_type = var.instance_type_list[0]
  #instance_type = var.instance_type_map["prod"]
  user_data = file("${path.module}/install-web.sh")
  key_name  = var.instance_keypair
  #for_each          = toset(data.aws_availability_zones.my_azs.names)
  for_each = toset(keys({ for type, t in data.aws_ec2_instance_type_offerings.ins_type3 :
  type => t.instance_types if length(t.instance_types) != 0 }))
  availability_zone = each.key
  vpc_security_group_ids = [
    aws_security_group.ssh_sg.id,
    aws_security_group.web_sg.id
  ]
  tags = {
    Name = "DemoWebApp-${each.value}"
  }

}
