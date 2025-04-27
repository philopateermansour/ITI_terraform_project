resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name = "redis-subnet-group"
  subnet_ids = [var.private_subnet_id, var.private_subnet_2_id]
  tags = {
    Name = "My cache Subnet Group"
  }
}

resource "aws_elasticache_cluster" "redis_cache" {
  cluster_id           = "redis-cluster"
  engine               = "redis"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = "7.0"
  port                 = 6379
  subnet_group_name = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids = [var.redis_sg]
  }