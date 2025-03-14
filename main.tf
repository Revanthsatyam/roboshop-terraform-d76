module "vpc" {
  source = "git::https://github.com/Revanthsatyam/tf-module-vpc-d76.git"

  env = var.env

  for_each = var.vpc
  cidr     = each.value["cidr"]
}