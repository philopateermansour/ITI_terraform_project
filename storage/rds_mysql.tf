resource "aws_db_subnet_group" "mysql_subnet_group" {
  name = "mysql-subnet-group"
  subnet_ids = [var.private_subnet_id, var.private_subnet_2_id]

  tags = {
    Name = "My DB Subnet Group"
  }
}
resource "aws_db_instance" "mysql_db" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "philo"
  password             = var.mysql_password
  publicly_accessible    = false
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.mysql_subnet_group.name
  vpc_security_group_ids = [var.mysql_sg]
}
