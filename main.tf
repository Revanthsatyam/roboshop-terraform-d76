module "vpc" {
  source = "git::https://github.com/Revanthsatyam/tf-module-vpc-d76.git"

  env                        = var.env
  tags                       = var.tags
  default_vpc_id             = var.default_vpc_id
  default_vpc_cidr           = var.default_vpc_cidr
  default_vpc_route_table_id = var.default_vpc_route_table_id

  for_each = var.vpc
  cidr     = each.value["cidr"]
  subnets  = each.value["subnets"]
}

module "alb" {
  depends_on = [module.vpc]
  source     = "git::https://github.com/Revanthsatyam/tf-module-alb-d76.git"

  env  = var.env
  tags = var.tags

  for_each           = var.alb
  internal           = each.value["internal"]
  load_balancer_type = each.value["load_balancer_type"]
  sg_port            = each.value["port"]
  ssh_ingress        = each.value["ssh_ingress"]
  vpc_id             = each.value["internal"] ? local.vpc_id : var.default_vpc_id
  subnets            = each.value["internal"] ? local.app_subnets : data.aws_subnets.default_vpc_subnets.ids
}

module "docdb" {
  depends_on = [module.vpc]
  source     = "git::https://github.com/Revanthsatyam/tf-module-docdb-d76.git"

  env  = var.env
  tags = var.tags

  subnet_ids  = local.db_subnets
  vpc_id      = local.vpc_id
  ssh_ingress = local.app_subnets_cidr

  for_each                = var.docdb
  sg_port                 = each.value["sg_port"]
  engine_family           = each.value["engine_family"]
  engine                  = each.value["engine"]
  engine_version          = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot     = each.value["skip_final_snapshot"]
  instance_count          = each.value["instance_count"]
  instance_class          = each.value["instance_class"]
}

module "rds" {
  depends_on = [module.vpc]
  source     = "git::https://github.com/Revanthsatyam/tf-module-rds-d76.git"

  env  = var.env
  tags = var.tags

  subnet_ids  = local.db_subnets
  vpc_id      = local.vpc_id
  ssh_ingress = local.app_subnets_cidr

  for_each                = var.rds
  sg_port                 = each.value["sg_port"]
  engine_family           = each.value["engine_family"]
  engine                  = each.value["engine"]
  engine_version          = each.value["engine_version"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot     = each.value["skip_final_snapshot"]
  instance_count          = each.value["instance_count"]
  instance_class          = each.value["instance_class"]
}

module "elasticache" {
  depends_on = [module.vpc]
  source     = "git::https://github.com/Revanthsatyam/tf-module-elasticache-d76.git"

  env  = var.env
  tags = var.tags

  subnet_ids  = local.db_subnets
  ssh_ingress = local.app_subnets_cidr
  vpc_id      = local.vpc_id

  for_each        = var.elasticache
  sg_port         = each.value["sg_port"]
  engine_family   = each.value["engine_family"]
  engine          = each.value["engine"]
  node_type       = each.value["node_type"]
  num_cache_nodes = each.value["num_cache_nodes"]
  engine_version  = each.value["engine_version"]
}

module "rabbitmq" {
  depends_on = [module.vpc]
  source     = "git::https://github.com/Revanthsatyam/tf-module-rabbitmq-d76.git"

  env              = var.env
  tags             = var.tags
  ssh_ingress_cidr = var.ssh_ingress_cidr
  amd_id           = var.ami_id

  vpc_id = local.vpc_id

  for_each      = var.rabbitmq
  sg_port_1     = each.value["sg_port_1"]
  sg_port_2     = each.value["sg_port_2"]
  instance_type = each.value["instance_type"]
}