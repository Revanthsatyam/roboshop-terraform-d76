default_vpc_route_table_id = "rtb-040b4e846292f4d3b"
default_vpc_cidr           = "172.31.0.0/16"
default_vpc_id             = "vpc-006ef82862dcda957"
env                        = "prod"
ami_id                     = "ami-0b4f379183e5706b9"
ssh_ingress_cidr           = ["172.31.25.133/32"]
hosted_zone_id             = "Z07966242J8KCTFJ55T6X"
prometheus_private_ip      = ["172.31.9.233/32"]
kms_key_arn                = "arn:aws:kms:us-east-1:058264090525:key/2c990b0f-c40d-4ede-957b-66ec02f92cf3"

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

docdb = {
  main = {
    sg_port                 = 27017
    engine_family           = "docdb4.0"
    engine                  = "docdb"
    engine_version          = "4.0.0"
    backup_retention_period = 5
    preferred_backup_window = "07:00-09:00"
    skip_final_snapshot     = true
    instance_count          = 1
    instance_class          = "db.t3.medium"
  }
}

rds = {
  main = {
    sg_port                 = 3306
    engine_family           = "aurora-mysql5.7"
    engine                  = "aurora-mysql"
    engine_version          = "5.7.mysql_aurora.2.11.3"
    backup_retention_period = 5
    preferred_backup_window = "07:00-09:00"
    skip_final_snapshot     = true
    instance_count          = 1
    instance_class          = "db.t3.small"
  }
}

elasticache = {
  main = {
    sg_port         = 6379
    engine_family   = "redis6.x"
    engine          = "redis"
    node_type       = "cache.t3.micro"
    num_cache_nodes = 1
    engine_version  = "6.2"
  }
}

rabbitmq = {
  main = {
    sg_port_1     = 5672
    sg_port_2     = 15672
    instance_type = "t3.micro"
  }
}

app = {
  frontend = {
    sg_port          = 80
    instance_type    = "t3.small"
    max_size         = 5
    min_size         = 1
    desired_capacity = 1
    priority         = 1
    parameters       = ["frontend", "nexus"]
  }
  catalogue = {
    sg_port          = 8080
    instance_type    = "t3.small"
    max_size         = 5
    min_size         = 1
    desired_capacity = 1
    priority         = 2
    parameters       = ["catalogue", "docdb", "nexus"]
  }
  user = {
    sg_port          = 8080
    instance_type    = "t3.small"
    max_size         = 5
    min_size         = 1
    desired_capacity = 1
    priority         = 3
    parameters       = ["user", "elasticache", "docdb", "nexus"]
  }
  cart = {
    sg_port          = 8080
    instance_type    = "t3.small"
    max_size         = 5
    min_size         = 1
    desired_capacity = 1
    priority         = 4
    parameters       = ["elasticache", "cart", "nexus"]
  }
  shipping = {
    sg_port          = 8080
    instance_type    = "t2.medium"
    max_size         = 5
    min_size         = 1
    desired_capacity = 1
    priority         = 5
    parameters       = ["shipping", "rds", "nexus"]
  }
  payment = {
    sg_port          = 8080
    instance_type    = "t3.small"
    max_size         = 5
    min_size         = 1
    desired_capacity = 1
    priority         = 6
    parameters       = ["payment", "nexus"]
  }
}