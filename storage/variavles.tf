variable "mysql_password" {
  type = string
  sensitive = true
}
variable "mysql_sg" {
  type = string
}
variable "redis_sg" {
  type = string
}
variable "public_subnet_id" {
  type = string
}
variable "private_subnet_id" {
  type = string
}
variable "private_subnet_2_id" {
  type = string
}