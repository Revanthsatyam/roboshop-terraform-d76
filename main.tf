module "vpc" {
  source = "git::https://github.com/Revanthsatyam/tf-module-vpc-d76.git"

  env  = var.env
  tags = var.tags

  for_each = var.vpc
  cidr     = each.value["cidr"]
  subnets  = each.value["subnets"]
}