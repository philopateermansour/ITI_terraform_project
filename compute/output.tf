output "mysql_security_group" {
  value = aws_security_group.redis_sg.id 
}
output "redis_security_group" {
  value = aws_security_group.redis_sg.id 
}