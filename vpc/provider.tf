terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.9.0"
    }
  }

  backend "s3" {
    bucket = "krishna-terraform-lock-hyd"
    key    = "session-05"
    region = "ap-south-2"
    dynamodb_table = "timing-lock"
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-2"
  
}
