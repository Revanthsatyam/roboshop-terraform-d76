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
  source = "git::https://github.com/Revanthsatyam/tf-module-alb-d76.git"

  env            = var.env
  tags           = var.tags
  subnets        = lookup(data.aws_subnets.default_vpc_subnets, "ids", null)

  for_each           = var.alb
  internal           = each.value["internal"]
  load_balancer_type = each.value["load_balancer_type"]
  sg_port            = each.value["port"]
  ssh_ingress        = each.value["ssh_ingress"]
  vpc_id             = each.value["internal"] ? local.vpc_id : var.default_vpc_id
}