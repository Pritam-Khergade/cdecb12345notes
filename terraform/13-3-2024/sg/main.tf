
resource "aws_security_group" "allow_tls" {
  name        = "${var.tag_name}-sg"
  description = "Allow TLS inbound traffic"
  dynamic "ingress" {
    for_each = var.sginbounds
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
