resource "aws_subnet" "subnets" {
  for_each = { for subnet in var.subnet_list : subnet.name => subnet }
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = each.value.cidr
  availability_zone = each.value.az
  map_public_ip_on_launch = each.value.public ? true : false
  tags = {
    Name = each.value.name
  }
}