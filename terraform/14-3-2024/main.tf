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


module "vpc" {
  source              = "./vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = ["10.0.1.0/24", "10.0.3.0/24"]
  private_subnet_cidr = ["10.0.2.0/24", "10.0.4.0/24", "10.0.5.0/24"]
  tag_name            = "cdec12345"
  env                 = "dev"
}
# why we are using IAC, reusable 

module "ec2" {
  source          = "./ec2"
  ami             = "ami-07d9b9ddc6cd8dd30"
  instance_type   = "t2.micro"
  key_name        = "pritam-terraform-nv"
  subnet_id       = module.vpc.public_subnet_id
  security_groups = module.sg.aws_sg
  public_ip       = true
  tags            = "cdec12345"
}


module "sg" {
  source = "./sg"
  vpc_id = module.vpc.vpc_id
  name   = "terraform-sg"
  tags   = "cdec12345"
}
