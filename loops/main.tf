resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = local.instance_tenancy
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "loops-timing"
    Terraform = "true"
    Environment = "DEV"
    createDate = local.current_time
  }
}

resource "aws_subnet" "public_subnet" {

    count = local.public_subnet_length
    vpc_id     = aws_vpc.main.id
    cidr_block       = var.public-subnet-cidr[count.index]
    availability_zone = var.az[count.index]
 

    tags = {
        Name = var.public_subnet_names[count.index]
        Terraform = "true"
        Environment = "DEV"
  }
}

resource "aws_subnet" "private_subnet" {

    for_each = var.private_subnets
    vpc_id     = aws_vpc.main.id
    cidr_block       = each.value.cidr
    availability_zone = each.value.az
 

    tags = {
        Name = each.value.Name
        Terraform = "true"
        Environment = "DEV"
  }
}

resource "aws_instance" "instance-1" {
  ami           = "ami-03f4878755434977f"
  //ami = local.ami_id
  instance_type = "t3.micro"
}
