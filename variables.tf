variable "aws_region" {
  type =  string
}
variable "vpc_name" {
  type = string
}
variable "vpc_cidr" {
  type = string
}
variable "subnet_list" {
  type = list(object({
    name = string
    cidr = string
    az   = string
    public = bool
  }))
}
variable "instance_type" {
  type = string
}
variable "mysql_password" {
  type = string
  sensitive = true
}
variable "email" {
  type = string
}