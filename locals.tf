locals {
  vpc_id           = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  app_subnets      = [ for k,v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "app", null), "subnet", null): v.id ]
  db_subnets       = [ for k,v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "db", null), "subnet", null): v.id ]
  app_subnets_cidr = [for k, v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "app", null), "subnet", null) : v.cidr_block]

#   private_alb_dns      = lookup(lookup(lookup(module.alb, "private", null), "alb", null), "dns_name", null)
#   public_alb_dns       = lookup(lookup(lookup(module.alb, "public", null), "alb", null), "dns_name", null)
#   private_alb_listener = lookup(lookup(lookup(module.alb, "private", null), "listener", null), "arn", null)
#   public_alb_listener  = lookup(lookup(lookup(module.alb, "public", null), "listener", null), "arn", null)
}