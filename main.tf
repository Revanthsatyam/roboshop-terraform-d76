module "vpc" {
  source = "git::https://github.com/Revanthsatyam/tf-module-vpc-d76.git"

  for_each = var.vpc
  cidr = each.value["cidr"]
}