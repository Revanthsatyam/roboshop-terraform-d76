module "vpc" {
  source = "git::https://github.com/Revanthsatyam/tf-module-vpc-d76.git"

  env            = var.env
  tags           = var.tags
  default_vpc_id = var.default_vpc_id
  default_cidr   = var.default_cidr

  for_each = var.vpc
  cidr     = each.value["cidr"]
  subnets  = each.value["subnets"]
}