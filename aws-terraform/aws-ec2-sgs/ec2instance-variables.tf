variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"

}
variable "instance_keypair" {
  description = "EC2 instances key pair"
  type        = string
  default     = "terraform-key2"

}
variable "private_instance_count" {
  description = "Private EC2 instance count"
  type        = number
  default     = 1

}