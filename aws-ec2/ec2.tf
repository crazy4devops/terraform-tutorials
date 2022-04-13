resource "aws_instance" "dev-ec2" {
  ami = data.aws_ami.amzlinux.id
  #instance_type = var.instance_type
  instance_type = var.instance_type_list[0]
  #instance_type = var.instance_type_map["prod"]
  user_data = file("${path.module}/install-web.sh")
  key_name  = var.instance_keypair
  count     = 3
  vpc_security_group_ids = [
    aws_security_group.ssh_sg.id,
    aws_security_group.web_sg.id
  ]
  tags = {
    Name = "DemoWebApp-${count.index}"
  }

}
#aws_instance.dev-ec2.0,1,2
#count = 5
#0,1,2,3,4
#count = 2
#0,1