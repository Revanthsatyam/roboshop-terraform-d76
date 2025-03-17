# output "vpc" {
#   value = module.vpc
# }

output "default_vpc_subnets" {
  value = data.aws_subnets.default_vpc_subnets
}