resource "aws_instance" "dev-ec2" {
  ami           = data.aws_ami.amzlinux.id
  instance_type = var.instance_type
  user_data     = file("${path.module}/install-web.sh")
  key_name      = var.instance_keypair
  vpc_security_group_ids = [
    aws_security_group.ssh_sg.id,
    aws_security_group.web_sg.id
  ]
  tags = {
    Name = "DemoWebApp"
  }

}