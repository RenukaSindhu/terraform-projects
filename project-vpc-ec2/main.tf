locals {
  region = "mumbai"
}

# Creating VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${local.region}-VPC"
  }
}

# Creating Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${local.region}-IGW"
  }
}

# Creating Subnets
resource "aws_subnet" "public_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.region}-public-subnet-${count.index + 1}"
  }
}

# Creating Route Tables
resource "aws_route_table" "public_rt" {
  count  = 2
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.traffic
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${local.region}-public-rt-${count.index + 1}"
  }
}

# Creating Subnet Association
resource "aws_route_table_association" "public_rt_assc" {
  count          = 2
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt[count.index].id
}
