resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy
  enable_dns_support = var.dns_support
  enable_dns_hostnames = var.dns_hostnames

  tags = var.tags
}

resource "aws_instance" "web_server" {
    count = 3
    ami           = "ami-03f4878755434977f"
    instance_type = "t2.micro"

tags = var.tags
}

resource "aws_instance" "web_server" {
    //count = 3
    ami           = "ami-03f4878755434977f"
    instance_type = "t2.micro"

tags = {
    Name = var.instance_names[count.index]
}
}

resource "aws_instance" "condition" {
    //count = 3
    ami           = "ami-03f4878755434977f"
    instance_type = var.isProd ? "t3.micro" : "t2.micro"

tags = var.tags
}