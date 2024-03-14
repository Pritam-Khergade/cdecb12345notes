output "public_subnet_id" {
  value = aws_subnet.public[0].id
}

output "private_subnet_id" {
  value = aws_subnet.private[*].id
}

output "vpc_id" {
  value = aws_vpc.main.id
}
