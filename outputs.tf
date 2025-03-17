output "vpc" {
  value = [ for k,v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "app", null), "subnet", null): v.id ]
}