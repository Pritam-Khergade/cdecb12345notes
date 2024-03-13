
resource "aws_instance" "web" {
  ami = var.ami
  # key_name               = aws_key_pair.deployer.key_name
  key_name                    = var.keyname
  instance_type               = var.instancetype
  security_groups             = [var.sg]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  tags = {
    Name = "${var.tag_name}-${var.env}-ec2"
  }
}

