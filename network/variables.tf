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
