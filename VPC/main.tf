resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
    Terraform = "true"
    Environment = "DEV"
  }
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = var.project_name
    Terraform = "true"
    Environment = "DEV"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "${var.project_name}-public-subnet"
    Terraform = "true"
    Environment = "DEV"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.project_name}-public-route-table"
    Terraform = "true"
    Environment = "DEV"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.11.0/24"

  tags = {
    Name = "${var.project_name}-private-subnet"
    Terraform = "true"
    Environment = "DEV"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  

  tags = {
    Name = "${var.project_name}-private-route-table"
    Terraform = "true"
    Environment = "DEV"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_subnet" "database_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.21.0/24"

  tags = {
    Name = "${var.project_name}-database-subnet"
    Terraform = "true"
    Environment = "DEV"
  }
}

resource "aws_route_table" "database_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "10.0.31.0/24"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "${var.project_name}-database-route-table"
    Terraform = "true"
    Environment = "DEV"
  }
}

resource "aws_route_table_association" "database" {
  subnet_id      = aws_subnet.database_subnet.id
  route_table_id = aws_route_table.database_route_table.id
}

resource "aws_eip" "nat" {
  
  domain   = "vpc"
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet.id

 
}


resource "aws_route" "private" {
  route_table_id            = aws_route_table.private_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.gw.id
  
}

resource "aws_route" "database" {
  route_table_id            = aws_route_table.database_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.gw.id
  
}