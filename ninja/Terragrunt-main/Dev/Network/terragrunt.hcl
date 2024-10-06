include {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Network_Skeleton_Module?ref=main"
}

inputs = {
    region              = "us-east-1"
    vpc_cidr = "10.0.0.0/25"
    public_subnets_cidr = ["10.0.0.0/28", "10.0.0.16/28"]
    public_subnets_az = ["us-east-1a", "us-east-1b"]
    private_subnets_cidr = ["10.0.0.32/28", "10.0.0.64/27", "10.0.0.96/28"]
    private_subnets_az = "us-east-1a"
    vpc_tags = {
        Name          = "dev-vpc"
        Enviroment    = "Dev"
        Owner         = "Vidhi"
    }
    public_subnets_az = ["us-east-1a", "us-east-1b"]
    private_subnets_az = "us-east-1a"
    vpc_enable_dns_hostnames = false
    vpc_enable_dns_support = true
    public_subnets_tags = [
    {
      Name = "public-subnet-01"
      Environment = "Dev"
      Owner =  "Vidhi"
    },
    {
      Name = "public-subnet-02"
      Environment = "Dev"
      Owner = "Vidhi"
    }
  ]
    private_subnets_tags = [
    {
      Name = "frontend-subnet"
      Environment = "Dev"
      Owner =  "Vidhi"
    },
    {
      Name = "backend-subnet"
      Environment = "Dev"
      Owner = "Vidhi"
    },
    {
      Name = "database-subnet"
      Environment = "Dev"
      Owner = "Vidhi"

    }
  ]
    igw_tags = {
    Name = "dev-igw-01"
    Environment = "Dev"
    Owner = "Vidhi"
  }

    nat_tags = {
    Name = "dev-nat-01"
    Environment = "Dev"
    Owner = "Vidhi"
    }

    public_route_table_tags = {
    Name = "dev-public-RTB-01"
    Environment = "Dev"
    Owner = "Vidhi"
    }

    private_route_table_tags = {
    Name = "dev-private-RTB-01"
    Environment = "Dev"
    Owner = "Vidhi"
    }

    frontend_nacl_ingress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.0.0/28"	
    from_port = 3000	
    to_port = 3000
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.0.0/28"
    from_port = 22	
    to_port = 22
    action = "allow"
    }, {
    rule_no = 130
    protocol = "tcp"
    cidr_block = "10.0.0.16/28"	
    from_port = 3000
    to_port = 3000
    action = "allow"
    }]

frontend_nacl_egress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 1024 
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.0.0/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.0.16/28"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }]

    frontend_nacl_tags  = {
    Name = "dev-frontend-nacl-01"
    Enviroment = "dev"
    Owner = "Vidhi"
  }

//BACKEND NACL

# ingress rules

backend_nacl_ingress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.0.0/28"	
    from_port = 8080
    to_port = 8080
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.0.96/28"
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 130
    protocol = "tcp"
    cidr_block = "10.0.0.16/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 140
    protocol = "tcp"
    cidr_block = "10.0.0.0/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 150
    protocol = "tcp"
    cidr_block = "10.0.0.0/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 160
    protocol = "tcp"
    cidr_block = "10.0.0.64/27"	
    from_port = 8080
    to_port = 8080
    action = "allow"
    }]

# egress rules

backend_nacl_egress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.0.96/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }, {
    rule_no = 130
    protocol = "tcp"
    cidr_block = "10.0.0.16/28"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }, {
    rule_no = 140
    protocol = "tcp"
    cidr_block = "10.0.0.0/28"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }]

backend_nacl_tags  = {
    Name = "dev-backend-nacl-01"
    Enviroment = "dev"
    Owner = "Vidhi"
  }

//DATABASE NACL

db_nacl_ingress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.0.0/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.0.64/27"
    from_port = 6379
    to_port = 6379
    action = "allow"
    }, {
    rule_no = 130
    protocol = "tcp"
    cidr_block = "10.0.0.64/27"	
    from_port = 9042
    to_port = 9042
    action = "allow"
    }, {
    rule_no = 140
    protocol = "tcp"
    cidr_block = "10.0.0.64/27"	
    from_port = 5432
    to_port = 5432
    action = "allow"
    }]

# egress rules

db_nacl_egress = [{
    rule_no = 100
    protocol = "tcp"
    cidr_block = "20.0.0.0/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 110
    protocol = "tcp"
    cidr_block = "10.0.0.64/27"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.0.0/28"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }]

db_nacl_tags  = {
    Name = "dev-db-nacl-01"
    Enviroment = "dev"
    Owner = "Vidhi"
  }

// ALB SECURITY GROUP

alb_sg_inbound_rules  = [{
      port     = 80
      source   = "0.0.0.0/0" 
      protocol = "tcp"  
    }, {
      port     = 443
      source   = "0.0.0.0/0" 
      protocol = "tcp"  
    }]

alb_sg_outbound_rules  = [
    {
      port     = 0  
      source   = "0.0.0.0/0"
      protocol = "-1"  
    }
  ]

/*--------------- ALB Security Group ---------------*/
alb_sg_name = "QA-alb-sg"
alb_sg_description = "Security group for QA-ALB"


alb_sg_tags = {
    Environment = "dev"
    Owner       = "Vidhi"
  }

/*--------------- ALB ---------------*/

 alb_deletion_protection = false

 alb_tags = {
    Enviroment = "Dev"
    Owner = "Vidhi"
  }
  /*--------------- Route 53 ---------------*/

route53_zone_tags = {
    Enviroment = "dev"
    Owner = "Vidhi"
  }

alb_listener_port = 80
alb_listener_protocol = "HTTP"


}
