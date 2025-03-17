data "aws_subnets" "default_vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = ["vpc-006ef82862dcda957"]
  }
}