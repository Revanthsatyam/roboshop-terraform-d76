output "alb" {
  value = lookup(lookup(module.alb, "private", null), "alb", null)
}