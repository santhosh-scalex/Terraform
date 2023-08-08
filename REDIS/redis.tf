# provider "aws" {
#   region = "us-east-2"
# }

# resource "aws_elasticache_subnet_group" "redis-subnet-group" {
#   name       = "redis-subnet-group"
#   subnet_ids = ["subnet-07cee3886a71958bc","subnet-0761803c631a2a21c"]
# }

# resource "aws_elasticache_cluster" "redis" {
#   cluster_id              = "redis-cluster"
#   engine                  = "redis"
#   node_type               = "cache.t2.micro"
#   num_cache_nodes         = 1
#   parameter_group_name    = "default.redis6.2"
#   port                    = 6379
#   subnet_group_name       = aws_elasticache_subnet_group.redis-subnet-group.name
#   security_group_ids      = ["sg-0f40cbdfeb98de2f1"]
#   availability_zone       = "us-east-2a"
#   maintenance_window      = "sun:05:00-sun:09:00"
#   snapshot_retention_limit = 0
#   snapshot_window         = "05:00-09:00"
#   tags = {
#     Name = "redis-cluster"
#   }
# }

