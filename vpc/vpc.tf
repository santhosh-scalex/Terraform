# provider "aws" {
#   region = "ap-south-2"
# }

resource "aws_vpc" "ss-vpc" {
  cidr_block       = var.cidr
  instance_tenancy = "default"

  tags = {
    Name = "ss-vpc"
  }
}

resource "aws_internet_gateway" "ss-igw" {
  vpc_id = aws_vpc.ss-vpc.id

  tags = {
    Name = "ss-igw"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.ss-vpc.id
  cidr_block = var.public_subnet_cidr 

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.ss-vpc.id
  cidr_block = var.private_subnet_cidr 

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.ss-vpc.id

  route {
    cidr_block = var.internet_cidr
    gateway_id = aws_internet_gateway.ss-igw.id
  }

   tags = {
    Name = "public-rt"
  }
}


resource "aws_eip" "ss-eip" {

tags = { 
    Name = "ss-eip"
}
}

resource "aws_nat_gateway" "ss-nat-gw" {
  allocation_id = aws_eip.ss-eip.id
  subnet_id     = aws_subnet.public-subnet.id
  tags = {
    Name = "ss-nat-gw"
  }
}
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.ss-vpc.id

  route {
    cidr_block = var.internet_cidr
    gateway_id = aws_nat_gateway.ss-nat-gw.id
  }

   tags = {
    Name = "private-rt"
  }
}
resource "aws_route_table_association" "public-rt-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id

}

resource "aws_route_table_association" "private-rt-association" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-rt.id

}


