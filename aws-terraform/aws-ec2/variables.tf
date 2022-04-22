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
  default = "terraform-key2"

}
variable "instance_type_list" {
  description = "instnace type is list"
  type        = list(string)
  default     = ["t3.micro", "t3.small", "t3.large"]
}
# var.instance_type_list[2]

variable "instance_type_map" {
  description = "instance type is map"
  type        = map(string)
  default = {
    "dev"  = "t3.micro"
    "qa"   = "t3.small"
    "prod" = "t3.large"
  }

}
#var.instnace_type_map["prod"]


