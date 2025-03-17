output "vpc" {
  value = lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "app", null)
}