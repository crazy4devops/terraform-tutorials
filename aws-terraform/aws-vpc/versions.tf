terraform {
  required_version = "~> 1.1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.8.0"
    }
  }

  backend "s3" {
    bucket = "terraform-bkt123"
    key    = "dev/proj1/terraform.tfstate"
    region = "us-east-1"

    # Enable during Step-09     
    # For State Locking
    dynamodb_table = "dev-proj1-vpc"    
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "default"

}