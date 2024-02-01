terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.33.0"
    }
  }
  /* backend "s3" {
    bucket = "terraform-k8-course"
    key    = "loops"
    region = "ap-south-1"
    dynamodb_table = "terraform-lock"
  } */
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

