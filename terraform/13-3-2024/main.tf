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

# terraform {
#   backend "s3" {
#     bucket = "cdec2021-tfstatefile"
#      key    = "tfstate-file/"
#     region = "us-east-1"
#     profile = "dev"
#   }
# }

# module "vpc" {
#   source         = "./vpc"
#   public_subnet  = ["10.0.1.0/24", "10.0.3.0/24"]
#   private_subnet = ["10.0.2.0/24", "10.0.4.0/24"]
#   vpc_cidr       = "10.0.0.0/16"
#   tag_name       = "cdec20-21"
#   env            = "dev"
# }


module "ec2" {
  source       = "./ec2"
  ami          = "ami-0f403e3180720dd7e"
  # subnet_id    = module.vpc.public_subnet_id
   subnet_id    = "subnet-04ef54d60c7759a7c"
  # vpcid        = module.vpc.vpcid
  vpcid     = "vpc-0637b80ea88abfb30"
  instancetype = "t2.micro"
  tag_name     = "cdec20-21"
  env          = "dev"
  keyname      = "pritam-terraform-nv"
  sg = module.sg.sgid
}




# module "s3" {
#   # for s3 backend tf statefile
#   source = "./s3"
#   bucketname = "cdec2021-tfstatefile"
# }


# module "s3bucket" {
#   source = "./s3"
#   bucketname = "maxisincdec2021"
# }

module "sg" {
  source = "./sg"
  tag_name = "cdec2021"
  sginbounds = [80,8080,443]
}
