resource "aws_route_table_association" "public_attach" {
  subnet_id      = aws_subnet.subnets["public-subnet"].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_attach" {
  subnet_id      = aws_subnet.subnets["private-subnet"].id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_2_attach" {
  subnet_id      = aws_subnet.subnets["private-subnet-2"].id
  route_table_id = aws_route_table.private_rt.id
}