output "subnet_list" {
  value = var.subnet_list
}

output "vpc_cidr" {
  value = var.vpc_cidr
}
output "vpc_id" {
  value = aws_vpc.my_vpc.id
}
output "public_subnet_id" {
  value = aws_subnet.subnets["public-subnet"].id
}
output "private_subnet_id" {
  value = aws_subnet.subnets["private-subnet"].id
}
output "private_subnet_2_id" {
  value = aws_subnet.subnets["private-subnet-2"].id
}
