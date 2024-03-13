
variable "vpc_cidr" {
  description = "vpc cidr"
  type        = string
}

variable "public_subnet_cidr" {
  description = "public_subnet cidr"
  type        = list(string)
}  
variable "private_subnet_cidr" {
  description = "private_subnet cidr"
  type        =  list(string)
}

variable "tag_name" {
  type    = string
}
variable "env" {
  
}
