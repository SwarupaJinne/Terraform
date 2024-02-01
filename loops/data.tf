data "aws_vpc" "default" {
  default = true
} 
output "vpc_info" {
  value = data.aws_vpc.default
}

/* data "aws_ami" "ami_id" {
  
  most_recent      = true
  
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10_hvm-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
} */


data "aws_region" "current" {
  
}

data "aws_availability_zones" "azs" {
    state = "available"
  
}