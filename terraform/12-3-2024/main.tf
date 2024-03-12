terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "dev"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.tag_name}-vpc"
    env = var.env
  }
}


resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = "${var.tag_name}-public-subnet"
    env = var.env
    # project = ""
    # owner = ""
    # user =  ""
  }
}
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = "${var.tag_name}-private-subnet"
    env = var.env
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "${var.tag_name}-public-rt"
    env = var.env
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.tag_name}-private-rt"
    env = var.env
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.tag_name}-igw"
    env = var.env
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.ip.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "${var.tag_name}-NAT"
    env = var.env
  }
}

resource "aws_eip" "ip" {
  domain = "vpc"
}



# resource "aws_instance" "web" {
#   ami                         = "ami-0f403e3180720dd7e"
#   instance_type               = "t2.micro"
#   key_name                    = "pritam-terraform-nv"
#   subnet_id                   = aws_subnet.public.id
#   associate_public_ip_address = true
#   tags = {
#     Name = "HelloWorld"
#   }
# }
