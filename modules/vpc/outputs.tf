output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "public_subnet_cidrs" {
  value = aws_subnet.public[*].cidr_block
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "private_subnet_cidrs" {
  value = aws_subnet.private[*].cidr_block
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.main[*].id
}

output "nat_gateway_ips" {
  value = aws_eip.nat[*].public_ip
}

output "internet_gateway_id" {
  value = aws_internet_gateway.main.id
}

output "availability_zones_count" {
  value = length(data.aws_availability_zones.available.names)
}

