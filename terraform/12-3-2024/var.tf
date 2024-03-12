variable "vpc_cidr" {
  description = "vpc cidr"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "public_subnet cidr"
  type        = string
  default     = "10.0.1.0/24"
}
variable "private_subnet_cidr" {
  description = "private_subnet cidr"
  type        = string
  default     = "10.0.2.0/24"
}

variable "tag_name" {
  type    = string
  default = "cdec12345"
}
variable "env" {
  default = "dev"
}
