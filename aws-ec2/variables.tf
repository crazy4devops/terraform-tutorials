variable "ami" {
  default = ""
}
variable "instance_type" {
  default = "t2.micro"
}
variable "profile" {
  default = "default"
}
variable "region" {
  default = "us-east-1"
}
variable "instance_keypair" {
  default = "terraform-key"

}

