variable "aws_region" {
  description = "Region in which AWS Resource to be created"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment variable used as a prefix"
  type        = string
  default     = "dev"

}

variable "business_division" {
  description = "Business Devision in the large  organizations"
  type        = string
  default     = "SAP"

}