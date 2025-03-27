output "app" {
  value = lookup(lookup(module.alb, "private", null), "dns_name", null)
}