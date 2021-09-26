output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "default_security_group_id" {
  value = aws_security_group.default.id
}

output "www_security_group_id" {
  value = aws_security_group.www.id
}

output "private_access_security_group_id" {
  value = aws_security_group.private_access.id
}
