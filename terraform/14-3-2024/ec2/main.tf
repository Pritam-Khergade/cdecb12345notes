resource "aws_instance" "web" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  security_groups = [var.security_groups]
  associate_public_ip_address = var.public_ip
  tags = {
    Name = var.tags
  }
}
