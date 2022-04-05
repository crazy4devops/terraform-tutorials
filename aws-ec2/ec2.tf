resource "aws_instance" "dev-ec2" {
  ami           = var.ami
  instance_type = var.instance_type
}