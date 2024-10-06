include "root" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Network_Skeleton_Module?ref=main"  

}

inputs = {
    region              = "us-east-1"
    vpc_cidr = "10.0.1.0/24"
    public_subnets_cidr = ["10.0.1.0/27", "10.0.1.32/27"]
    private_subnets_cidr = ["10.0.1.64/27", "10.0.1.96/27", "10.0.1.128/27"]
    vpc_tags = {
        Name          = "QA-vpc"
        Enviroment    = "QA"
        Owner         = "Vidhi"
    }
    public_subnets_az = ["us-east-1a", "us-east-1b"]
    private_subnets_az = "us-east-1a"
    public_subnets_tags = [
    {
      Name = "public-subnet-01"
      Environment = "QA"
      Owner =  "Vidhi"
    },
    {
      Name = "public-subnet-02"
      Environment = "QA"
      Owner = "Vidhi"
    }
  ]
    private_subnets_tags = [
    {
      Name = "frontend-subnet"
      Environment = "QA"
      Owner =  "Vidhi"
    },
    {
      Name = "backend-subnet"
      Environment = "QA"
      Owner = "Vidhi"
    },
    {
      Name = "database-subnet"
      Environment = "QA"
      Owner = "Vidhi"

    }
  ]
    igw_tags = {
    Name = "QA-igw-01"
    Environment = "QA"
    Owner = "Vidhi"
  }

    nat_tags = {
    Name = "QA-nat-01"
    Environment = "QA"
    Owner = "Vidhi"
    }

    public_route_table_tags = {
    Name = "QA-public-RTB-01"
    Environment = "QA"
    Owner = "Vidhi"
    }

    private_route_table_tags = {
    Name = "qa-private-RTB-01"
    Environment = "QA"
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
    cidr_block = "10.0.1.0/28"	
    from_port = 3000	
    to_port = 3000
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.1.0/28"
    from_port = 22	
    to_port = 22
    action = "allow"
    }, {
    rule_no = 130
    protocol = "tcp"
    cidr_block = "10.0.1.64/28"	
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
    cidr_block = "10.0.1.0/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.1.64/28"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }]

    frontend_nacl_tags  = {
    Name = "QA-frontend-nacl-01"
    Enviroment = "QA"
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
    cidr_block = "10.0.1.0/28"	
    from_port = 8080
    to_port = 8080
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.1.48/28"
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 130
    protocol = "tcp"
    cidr_block = "10.0.1.64/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 140
    protocol = "tcp"
    cidr_block = "10.0.1.0/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 150
    protocol = "tcp"
    cidr_block = "10.0.1.0/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 160
    protocol = "tcp"
    cidr_block = "10.0.1.64/28"	
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
    cidr_block = "10.0.1.48/28"	
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
    cidr_block = "10.0.1.64/28"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }, {
    rule_no = 140
    protocol = "tcp"
    cidr_block = "10.0.1.0/28"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }]

backend_nacl_tags  = {
    Name = "QA-backend-nacl-01"
    Enviroment = "QA"
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
    cidr_block = "10.0.1.0/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.1.32/28"
    from_port = 6379
    to_port = 6379
    action = "allow"
    }, {
    rule_no = 130
    protocol = "tcp"
    cidr_block = "10.0.1.32/28"	
    from_port = 9042
    to_port = 9042
    action = "allow"
    }, {
    rule_no = 140
    protocol = "tcp"
    cidr_block = "10.0.1.32/28"	
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
    cidr_block = "10.0.1.32/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.1.0/28"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }]

db_nacl_tags  = {
    Name = "QA-db-nacl-01"
    Enviroment = "QA"
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
    Environment = "QA"
    Owner       = "Vidhi"
  }

/*--------------- ALB ---------------*/

 alb_deletion_protection = false

 alb_tags = {
    Enviroment = "QA"
    Owner = "Vidhi"
  }
  /*--------------- Route 53 ---------------*/

route53_zone_tags = {
    Enviroment = "QA"
    Owner = "Vidhi"
  }



}
