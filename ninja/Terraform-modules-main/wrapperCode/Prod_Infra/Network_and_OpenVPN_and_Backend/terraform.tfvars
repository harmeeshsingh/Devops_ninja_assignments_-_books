aws_region = "us-east-1"

# ************************************ Network ************************************ # 

/*--------------- VPC ---------------*/

vpc_cidr = "192.168.0.0/24"
vpc_enable_dns_support = true
vpc_enable_dns_hostnames = false
vpc_tags = {
  Name = "OT-Micro-Prod-VPC"
  Enviroment = "Prod"
  Owner = "Vishal"
}

/*--------------- Public Subnets ---------------*/

public_subnets_cidr = ["192.168.0.0/28", "192.168.0.16/28"]
enable_map_public_ip_on_launch = true
public_subnets_tags = [
  {
    Name = "Public-Subnet"
    Enviroment = "Prod"
    Owner = "Vishal"
  },
  {
    Name = "Public-Subnet"
    Enviroment = "Prod"
    Owner = "Vishal"
  }
]

/*--------------- Private Subnets ---------------*/

private_subnets_cidr = ["192.168.0.32/28", "192.168.0.48/28", "192.168.0.64/27", "192.168.0.96/27", "192.168.0.192/27", "192.168.0.224/27"]
private_subnets_tags = [
  {
    Name = "Frontend-Pvt-Subnet"
    Enviroment = "Prod"
    Owner = "Vishal"
  },
  {
    Name = "Frontend-Pvt-Subnet"
    Enviroment = "Prod"
    Owner = "Vishal"
  },
  {
    Name = "Backend-Pvt-Subnet"
    Enviroment = "Prod"
    Owner = "Vishal"
  },
  {
    Name = "Backend-Pvt-Subnet"
    Enviroment = "Prod"
    Owner = "Vishal"
  },
  {
    Name = "Database-Pvt-Subnet"
    Enviroment = "Prod"
    Owner = "Vishal"
  },
  {
    Name = "Database-Pvt-Subnet"
    Enviroment = "Prod"
    Owner = "Vishal"
  }
]

/*--------------- # Internet Gateway ---------------*/

igw_tags = {
  Name = "Prod-Internat-Gateway"
  Enviroment = "Prod"
  Owner = "Vishal"
}

/*--------------- # Elastic IP ---------------*/

elastic_ip = 2


/*--------------- # NAT Gateway ---------------*/

nat = 2
nat_tags =[{
    Name = "Prod-Nat"
    Enviroment = "Prod"
    Owner = "Vishal"
    }, {
    Name = "Prod-Nat"
    Enviroment = "Prod"
    Owner = "Vishal"
  }]

/*--------------- # Route Table ---------------*/

public_route_table_tags = {
  Name = "Prod-Public-RTB"
  Enviroment = "Prod"
  Owner = "Vishal"
}

private_route_table_tags = [{
    Name = "Prod-Private-RTB"
    Enviroment = "Prod"
    Owner = "Vishal"
    }, {
    Name = "Prod-Private-RTB"
    Enviroment = "Prod"
    Owner = "Vishal"
  }]

specific_subnet_AZ01           = [0, 2, 4]
specific_subnet_AZ02           = [1, 3, 5]  
/*--------------- Frontend NACL ---------------*/

frontend_nacl_ingress = [{
  rule_no    = 100
  protocol   = "tcp"
  cidr_block = "20.0.0.0/28" // management  network
  from_port  = 22
  to_port    = 22
  action     = "allow"
  }, {
  rule_no    = 110
  protocol   = "tcp"
  cidr_block = "192.168.0.0/28" // Vishal-vpc  public subnet-01 cidr
  from_port  = 3000
  to_port    = 3000
  action     = "allow"
  }, {
  rule_no    = 120
  protocol   = "tcp"
  cidr_block = "192.168.0.0/28" // Vishal-vpc  public subnet-01 cidr
  from_port  = 22
  to_port    = 22
  action     = "allow"
  }, {
  rule_no    = 130
  protocol   = "tcp"
  cidr_block = "192.168.0.16/28" // Vishal-vpc  public subnet-02 cidr
  from_port  = 3000
  to_port    = 3000
  action     = "allow"
}]

frontend_nacl_egress = [{
  rule_no    = 100
  protocol   = "tcp"
  cidr_block = "20.0.0.0/28" // management-vpc jenkins subnet cidr
  from_port  = 1024
  to_port    = 65535
  action     = "allow"
  }, {
  rule_no    = 110
  protocol   = "tcp"
  cidr_block = "192.168.0.0/28" // Vishal-vpc  public subnet-01 cidr
  from_port  = 1024
  to_port    = 65535
  action     = "allow"
  }, {
  rule_no    = 120
  protocol   = "tcp"
  cidr_block = "192.168.0.16/28" // Vishal-vpc  public subnet-02 cidr
  from_port  = 1024
  to_port    = 65535
  action     = "allow"
}]

frontend_nacl_tags = {
  Name       = "Prod-Frontend-NACL"
  Enviroment = "Prod"
  Owner      = "Vishal"
}

/*--------------- Backend NACL ---------------*/

# ingress rules

backend_nacl_ingress = [{
  rule_no    = 100
  protocol   = "tcp"
  cidr_block = "20.0.0.0/28" // management-vpc jenkins subnet cidr
  from_port  = 22
  to_port    = 22
  action     = "allow"
  }, {
  rule_no    = 110
  protocol   = "tcp"
  cidr_block = "192.168.0.0/28" // Vishal-vpc  public subnet-01 cidr
  from_port  = 8080
  to_port    = 8080
  action     = "allow"
  }, {
  rule_no    = 120
  protocol   = "tcp"
  cidr_block = "192.168.0.192/27" // Vishal-vpc database subnet-01 cidr
  from_port  = 1024
  to_port    = 65535
  action     = "allow"
  },
  {
  rule_no    = 125
  protocol   = "tcp"
  cidr_block = "192.168.0.224/27" // Vishal-vpc database subnet-02 cidr
  from_port  = 1024
  to_port    = 65535
  action     = "allow"
  }, {
  rule_no    = 130
  protocol   = "tcp"
  cidr_block = "192.168.0.16/28" // Vishal-vpc  public subnet-02 cidr
  from_port  = 1024
  to_port    = 65535
  action     = "allow"
  }, {
  rule_no    = 140
  protocol   = "tcp"
  cidr_block = "192.168.0.0/28" // Vishal-vpc  public subnet-01 cidr
  from_port  = 22
  to_port    = 22
  action     = "allow"
  }, {
  rule_no    = 150
  protocol   = "tcp"
  cidr_block = "192.168.0.0/28" // Vishal-vpc  public subnet-01 cidr
  from_port  = 1024
  to_port    = 65535
  action     = "allow"
  }, {
  rule_no    = 160
  protocol   = "tcp"
  cidr_block = "192.168.0.16/28" // Vishal-vpc  public subnet-02 cidr
  from_port  = 8080
  to_port    = 8080
  action     = "allow"
}]

# egress rules

backend_nacl_egress = [{
  rule_no    = 100
  protocol   = "tcp"
  cidr_block = "20.0.0.0/28" // management-vpc jenkins subnet cidr
  from_port  = 22
  to_port    = 22
  action     = "allow"
  }, {
  rule_no    = 110
  protocol   = "tcp"
  cidr_block = "192.168.0.192/27" // Vishal-vpc database subnet cidr
  from_port  = 1024
  to_port    = 65535
  action     = "allow"
  },{
  rule_no    = 115
  protocol   = "tcp"
  cidr_block = "192.168.0.224/27" // Vishal-vpc database subnet cidr
  from_port  = 1024
  to_port    = 65535
  action     = "allow"
  }, {
  rule_no    = 120
  protocol   = "tcp"
  cidr_block = "20.0.0.0/28" // management-vpc jenkins subnet cidr
  from_port  = 1024
  to_port    = 65535
  action     = "allow"
  }, {
  rule_no    = 130
  protocol   = "tcp"
  cidr_block = "192.168.0.16/28" // Vishal-vpc  public subnet-02 cidr
  from_port  = 1024
  to_port    = 65535
  action     = "allow"
  }, {
  rule_no    = 140
  protocol   = "tcp"
  cidr_block = "192.168.0.0/28" // Vishal-vpc  public subnet-01 cidr
  from_port  = 1024
  to_port    = 65535
  action     = "allow"
}]

backend_nacl_tags = {
  Name       = "Prod-Backend-NACL"
  Enviroment = "Prod"
  Owner      = "Vishal"
}

/*--------------- Database NACL ---------------*/

db_nacl_ingress = [{
  rule_no    = 100
  protocol   = "tcp"
  cidr_block = "20.0.0.0/28" // management-vpc jenkins subnet cidr
  from_port  = 22
  to_port    = 22
  action     = "allow"
  }, {
  rule_no    = 110
  protocol   = "tcp"
  cidr_block = "192.168.0.0/28" // Vishal-vpc  public subnet-01 cidr
  from_port  = 22
  to_port    = 22
  action     = "allow"
  }, {
  rule_no    = 120
  protocol   = "tcp"
  cidr_block = "198.168.0.64/27" // Vishal-vpc backend subnet -01cidr 
  from_port  = 6379
  to_port    = 6379
  action     = "allow"
  },
  {
  rule_no    = 125
  protocol   = "tcp"
  cidr_block = "192.168.0.96/27" // Vishal-vpc backend subnet -02cidr 
  from_port  = 6379
  to_port    = 6379
  action     = "allow"
  }, {
  rule_no    = 130
  protocol   = "tcp"
  cidr_block = "198.168.0.64/27" // Vishal-vpc backend subnet-01 cidr
  from_port  = 9042
  to_port    = 9042
  action     = "allow"
  },{
  rule_no    = 135
  protocol   = "tcp"
  cidr_block = "192.168.0.96/27" // Vishal-vpc backend subnet-02 cidr
  from_port  = 9042
  to_port    = 9042
  action     = "allow"
  },
  {
  rule_no    = 140
  protocol   = "tcp"
  cidr_block = "198.168.0.64/27" // Vishal-vpc backend subnet-01 cidr
  from_port  = 5432
  to_port    = 5432
  action     = "allow"
  }, {
  rule_no    = 145
  protocol   = "tcp"
  cidr_block = "192.168.0.96/27" // Vishal-vpc backend subnet-01 cidr
  from_port  = 5432
  to_port    = 5432
  action     = "allow"
}]

# egress rules

db_nacl_egress = [{
  rule_no    = 100
  protocol   = "tcp"
  cidr_block = "20.0.0.0/28" // management-vpc jenkins subnet cidr
  from_port  = 1024
  to_port    = 65535
  action     = "allow"
  }, {
  rule_no    = 110
  protocol   = "tcp"
  cidr_block = "198.168.0.64/27" // Vishal-vpc backend subnet-01 cidr
  from_port  = 1024
  to_port    = 65535
  action     = "allow"
  },{
  rule_no    = 110
  protocol   = "tcp"
  cidr_block = "198.168.0.64/27" // Vishal-vpc backend subnet-02 cidr
  from_port  = 1024
  to_port    = 65535
  action     = "allow"
  },  {
  rule_no    = 120
  protocol   = "tcp"
  cidr_block = "192.168.0.0/28" // Vishal-vpc  public subnet-01 cidr
  from_port  = 1024
  to_port    = 65535
  action     = "allow"
}]

db_nacl_tags = {
  Name       = "Prod-Database-NACL"
  Enviroment = "Prod"
  Owner      = "Vishal"
}

/*--------------- ALB Security Group ---------------*/


alb_sg_name = "Prod-ALB-SG"
alb_sg_description = "Security group for Prod-ALB"
alb_sg_inbound_rules = [
  {
    port     = 80
    source   = "0.0.0.0/0"
    protocol = "tcp"
  },
  {
    port     = 443
    source   = "0.0.0.0/0"
    protocol = "tcp"
  }
]
alb_sg_outbound_rules = [
  {
    port     = 0
    source   = "0.0.0.0/0"
    protocol = "-1"
  }
]
alb_sg_tags = {
  Name = "Prod-ALB-SG"
  Environment = "Prod"
  Owner = "Vishal"
}


/*--------------- ALB ---------------*/

alb_name = "Prod-ALB"
alb_internal = false
alb_type = "application"
alb_deletion_protection = true
alb_tags = {
  Name = "Prod-ALB"
  Enviroment = "Prod"
  Owner = "Vishal"
}

alb_listener_port = 80
alb_listener_protocol = "HTTP"

/*--------------- Listner ---------------*/

route53_zone_tags = {
  Enviroment = "Prod"
  Owner = "Vishal"
}
region = "us-east-1"
route53_zone_name = "example.com"

# ************************************ Open VPN ************************************ # 


key_name            = "OT_Prod"
server_type         = "t2.micro"
server_name         = "Prod-Open-VPN"
Env                 = "Prod"
Owner               = "Vishal"
sec_grp_name        = "Prod-Open-SG"
Sec_grp_description = "Security group for Open Vpn in Prod Env"
inbound_ports       = [
     { port = 22, protocol = "TCP", cidr_blocks = "20.0.0.0/28" }, 
    { port = 1194, protocol = "UDP", cidr_blocks = "0.0.0.0/0" },
]
outbound_ports      = [ 
   { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" },
 ]
Sec_grp_tags       = {
    Name        = "Prod-Open-SG"
    Environment = "Prod"
    Owner       = "Vishal"
  }
instance_count      = 2
associate_public_ip = true


# ************************************ Redis ************************************ # 

redis_key_name            = "OT_Prod_Redis"
redis_server_type         = "t2.micro"
redis_server_name         = "Prod-Redis"
redis_Env                 = "Prod"
redis_Owner               = "Vishal"
redis_sec_grp_name        = "Prod-Redis-SG"
redis_Sec_grp_description = "Security group for Redis in Prod Env"
redis_inbound_ports       = [
    { port = 22, protocol = "TCP", cidr_blocks = "20.0.0.0/28" }, 
    { port = 22, protocol = "TCP", security_group_ids = "sg-0275fdd4271ad6765" }, # OpenVPN
    { port = 6379, protocol = "TCP", security_group_ids = "sg-0807df8a9a390a5d3" }, # Employee SG
    { port = 6379, protocol = "TCP", security_group_ids = "sg-06e58f4c742e20147" }, # Attendance SG
    { port = 6379, protocol = "TCP", security_group_ids = "sg-041cf8cd7138da20f" }, # Salary SG
]

redis_outbound_ports      = [ 
   { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" },
 ]
redis_Sec_grp_tags       = {
    Name        = "Prod-Redis-SG"
    Environment = "Prod"
    Owner       = "Vishal"
  }
redis_instance_count      = 2
redis_associate_public_ip = false

# ************************************ Postgres ************************************ # 

pgsql_key_name            = "OT_Prod_Pgsql"
pgsql_server_type         = "t2.micro"
pgsql_server_name         = "Prod-Pgsql"
pgsql_Env                 = "Prod"
pgsql_Owner               = "Vishal"
pgsql_sec_grp_name        = "Prod-Pgsql-SG"
pgsql_Sec_grp_description = "Security group for Postgresql in Prod Env"
pgsql_inbound_ports       = [
    { port = 22, protocol = "TCP", cidr_blocks = "20.0.0.0/28" }, 
    { port = 22, protocol = "TCP", security_group_ids = "sg-0275fdd4271ad6765" }, # OpenVPN
    { port = 5432, protocol = "TCP", security_group_ids = "sg-06e58f4c742e20147" }, # Attendance SG
]
pgsql_outbound_ports      = [ 
   { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" },
 ]
pgsql_Sec_grp_tags       = {
    Name        = "Prod-Pgsql-SG"
    Environment = "Prod"
    Owner       = "Vishal"
  }
pgsql_instance_count      = 2
pgsql_associate_public_ip = false

# ************************************ Scylla ************************************ # 

scylla_key_name            = "OT_Prod_Scylla"
scylla_server_type         = "t2.micro"
scylla_server_name         = "Prod-Scylla"
scylla_Env                 = "Prod"
scylla_Owner               = "Vishal"
scylla_sec_grp_name        = "Prod-Scylla-SG"
scylla_Sec_grp_description = "Security group for Scylla in Prod Env"
scylla_inbound_ports       = [
    { port = 22, protocol = "TCP", cidr_blocks = "20.0.0.0/28" }, 
    { port = 22, protocol = "TCP", security_group_ids = "sg-0275fdd4271ad6765" }, # OpenVPN
    { port = 9042, protocol = "TCP", security_group_ids = "sg-0807df8a9a390a5d3" }, # Employee SG
    { port = 9042, protocol = "TCP", security_group_ids = "sg-041cf8cd7138da20f" }, # Salary SG
]
scylla_outbound_ports      = [ 
   { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" },
 ]
scylla_Sec_grp_tags       = {
    Name        = "Prod-Scylla-SG"
    Environment = "Prod"
    Owner       = "Vishal"
  }
scylla_instance_count      = 2
scylla_associate_public_ip = false
