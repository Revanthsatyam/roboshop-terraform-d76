output "vpc" {
  value = lookup(module.vpc, "vpc_id", null)
}