module "my_network" {
  source        = "./network"
  subnet_list   = var.subnet_list                    
  vpc_name      = var.vpc_name
  vpc_cidr      = var.vpc_cidr       
}
module "compute" {
  source              = "./compute"
  instance_type       = var.instance_type
  vpc_id              = module.my_network.vpc_id
  vpc_cidr            = module.my_network.vpc_cidr 
  public_subnet_id    = module.my_network.public_subnet_id
  private_subnet_id   = module.my_network.private_subnet_id
  private_subnet_2_id = module.my_network.private_subnet_2_id
  email               = var.email
}

module "storage" {
  source              = "./storage"
  mysql_password      = var.mysql_password
  mysql_sg            = module.compute.mysql_security_group
  redis_sg            = module.compute.redis_security_group
  public_subnet_id    = module.my_network.public_subnet_id
  private_subnet_id   = module.my_network.private_subnet_id
  private_subnet_2_id = module.my_network.private_subnet_2_id
}
