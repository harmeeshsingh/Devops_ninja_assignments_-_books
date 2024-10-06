region = "us-east-2"
/*--------------- VPC ---------------*/
vpc_tags = {
    Name = "QA-vpc"
    Enviroment = "QA"
    Owner = "shreya"
}

/*--------------- Public Subnets ---------------*/
public_subnets_cidr = ["10.0.1.128/28", "10.0.1.144/28"]

public_subnets_az = ["us-east-2a", "us-east-2b"]

enable_map_public_ip_on_launch = true

public_subnets_tags  = [{
    Name = "public-subnet-01"
    Enviroment = "QA"
    Owner = "shreya"
    }, {
    Name = "public-subnet-02"
    Enviroment = "QA"
    Owner = "shreya"
  }]


/*--------------- Private Subnets ---------------*/

private_subnets_cidr = ["10.0.1.160/28", "10.0.1.176/28", "10.0.1.192/28"]

private_subnets_az = "us-east-2a"

private_subnets_tags = [{
    Name = "frontend-subnet"
    Enviroment = "QA"
    Owner = "shreya"
    }, {
    Name = "backend-subnet"
    Enviroment = "QA"
    Owner = "shreya"
  }, {
    Name = "database-subnet"
    Enviroment = "QA"
    Owner = "shreya"
  }]

/*--------------- IGW ---------------*/

igw_tags = {
    Name = "QA-igw-01"
    Enviroment = "QA"
    Owner = "shreya"
  }

/*--------------- NAT Gateway ---------------*/

nat_tags = {
    Name = "QA-nat-01"
    Enviroment = "QA"
    Owner = "shreya"
  }

/*--------------- # Route Table ---------------*/

public_route_table_tags = {
    Name = "QA-public-RTB-01"
    Enviroment = "QA"
    Owner = "shreya"
  }

private_route_table_tags  = {
    Name = "QA-private-RTB-01"
    Enviroment = "QA"
    Owner = "shreya"
  }

/*--------------- Frontend NACL ---------------*/

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
    cidr_block = "10.0.1.128/28"	
    from_port = 3000	
    to_port = 3000
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.1.128/28"
    from_port = 22	
    to_port = 22
    action = "allow"
    }, {
    rule_no = 130
    protocol = "tcp"
    cidr_block = "10.0.1.144/28"	
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
    cidr_block = "10.0.1.128/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.1.144/28"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }]

frontend_nacl_tags  = {
    Name = "QA-frontend-nacl-01"
    Enviroment = "QA"
    Owner = "shreya"
  }

/*--------------- Backend NACL ---------------*/

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
    cidr_block = "10.0.1.128/28"	
    from_port = 8080
    to_port = 8080
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.1.192/28"
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 130
    protocol = "tcp"
    cidr_block = "10.0.1.144/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 140
    protocol = "tcp"
    cidr_block = "10.0.1.128/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 150
    protocol = "tcp"
    cidr_block = "10.0.1.128/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 160
    protocol = "tcp"
    cidr_block = "10.0.1.144/28"	
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
    cidr_block = "10.0.1.192/28"	
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
    cidr_block = "10.0.1.144/28"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }, {
    rule_no = 140
    protocol = "tcp"
    cidr_block = "10.0.1.128/28"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }]

backend_nacl_tags  = {
    Name = "QA-backend-nacl-01"
    Enviroment = "QA"
    Owner = "shreya"
  }

/*--------------- Database NACL ---------------*/

# ingress rules

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
    cidr_block = "10.0.1.128/28"	
    from_port = 22
    to_port = 22
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.1.176/28"
    from_port = 6379
    to_port = 6379
    action = "allow"
    }, {
    rule_no = 130
    protocol = "tcp"
    cidr_block = "10.0.1.176/28"	
    from_port = 9042
    to_port = 9042
    action = "allow"
    }, {
    rule_no = 140
    protocol = "tcp"
    cidr_block = "10.0.1.176/28"	
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
    cidr_block = "10.0.1.176/28"	
    from_port = 1024
    to_port = 65535
    action = "allow"
    }, {
    rule_no = 120
    protocol = "tcp"
    cidr_block = "10.0.1.128/28"	
    from_port = 1024
    to_port =  65535
    action = "allow"
    }]

db_nacl_tags  = {
    Name = "QA-db-nacl-01"
    Enviroment = "QA"
    Owner = "shreya"
  }

/*--------------- ALB Security Group ---------------*/

alb_sg_name = "QA-alb-sg"

alb_sg_description = "Security group for QA-ALB"

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

alb_sg_tags = {
    Environment = "QA"
    Owner       = "shreya"
  }

/*--------------- ALB ---------------*/

 alb_deletion_protection = false
 alb_name = "QA-alb"

 alb_type = "application"
 alb_internal = false
 alb_tags = {
    Enviroment = "QA"
    Owner = "shreya"
  }
  /*--------------- Route 53 ---------------*/

route53_zone_tags = {
    Enviroment = "QA"
    Owner = "shreya"
  }
route53_zone_name = "example.com"
