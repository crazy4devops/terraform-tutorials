terraform {
  #required_version = "~> 0.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.8.0"
    }
  }
}
provider "aws" {
  profile = var.profile
  region  = var.region
}