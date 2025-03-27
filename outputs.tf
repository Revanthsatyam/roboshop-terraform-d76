output "app" {
  value = lookup(module.alb, "main", null)
}