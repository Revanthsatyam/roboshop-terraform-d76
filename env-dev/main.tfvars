default_vpc_route_table_id = "rtb-040b4e846292f4d3b"
default_vpc_cidr           = "172.31.0.0/16"
default_vpc_id             = "vpc-006ef82862dcda957"
env                        = "dev"

tags = {
  company_name  = "ABC Tech"
  business_unit = "Ecommerce"
  project_name  = "robotshop"
  cost_center   = "ecom_rs"
  created_by    = "terraform"
}

vpc = {
  main = {
    cidr = "10.0.0.0/16"
    subnets = {
      public = {
        public1 = { cidr = "10.0.0.0/24", az = "us-east-1a" }
        public2 = { cidr = "10.0.1.0/24", az = "us-east-1b" }
      }
      app = {
        app1 = { cidr = "10.0.2.0/24", az = "us-east-1a" }
        app2 = { cidr = "10.0.3.0/24", az = "us-east-1b" }
      }
      db = {
        db1 = { cidr = "10.0.4.0/24", az = "us-east-1a" }
        db2 = { cidr = "10.0.5.0/24", az = "us-east-1b" }
      }
    }
  }
}

alb = {
  public = {
    internal           = false
    load_balancer_type = "application"
    port               = 80
    ssh_ingress        = ["0.0.0.0/0"]
  }
  private = {
    internal           = true
    load_balancer_type = "application"
    port               = 80
    ssh_ingress        = ["10.0.0.0/16", "172.31.0.0/16"]
  }
}