locals {
  vpc_id      = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  app_subnets = [ for k,v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "app", null), "subnet", null): v.id ]
  db_subnets  = [ for k,v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "db", null), "subnet", null): v.id ]

  app_subnets_cidr = [for k, v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "app", null), "subnet", null) : v.cidr_block]
}