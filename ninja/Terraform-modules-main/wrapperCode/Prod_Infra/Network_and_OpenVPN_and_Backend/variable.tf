variable "region" {
  type    = string
  default = "us-east-2"
}

# ************************************ Network ************************************ # 

/*---------------vpc variables---------------*/

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/25"
}

variable "vpc_enable_dns_support" {
  type    = bool
  default = true
}

variable "vpc_enable_dns_hostnames" {
  type    = bool
  default = false
}

variable "vpc_tags" {
  type    = map(string)
  default = {
    Name = "Prod-VPC"
    Enviroment = "Prod"
    Owner = "vishal"
  }
}

/*--------------- Public Subnets ---------------*/

variable "public_subnets_cidr" {
  description = "public subnet cidr block"
  type        = list(string)
  default     = ["10.0.0.0/28", "10.0.0.16/28"]

}

variable "aws_region" {
  type = string
  default = "us-east-1"
  
}
variable "enable_map_public_ip_on_launch" {
  type    = bool
  default = true
}

variable "public_subnets_tags" {
  description = "public subnet tags"
  type        = list(map(string))
  default = [{
    Name = "public-subnet-01"
    Enviroment = "dev"
    Owner = "shreya"
    }, {
    Name = "public-subnet-02"
    Enviroment = "dev"
    Owner = "shreya"
  }]
}

/*--------------- Private Subnets ---------------*/

variable "private_subnets_cidr" {
  description = "private subnet cidr block"
  type        = list(string)
  default     = ["10.0.0.32/28", "10.0.0.64/27", "10.0.0.96/28"]

}


variable "private_subnets_tags" {
  description = "private subnet tags"
  type        = list(map(string))
  default = [{
    Name = "frontend-subnet"
    Enviroment = "dev"
    Owner = "shreya"
    }, {
    Name = "backend-subnet"
    Enviroment = "dev"
    Owner = "shreya"
  }, {
    Name = "database-subnet"
    Enviroment = "dev"
    Owner = "shreya"
  }]
}

/*--------------- # Internet Gateway ---------------*/

variable "igw_tags" {
  type    = map(string)
  default = {
    Name = "dev-igw-01"
    Enviroment = "dev"
    Owner = "shreya"
  }
}
/*--------------- # Elastic IP ---------------*/


variable "elastic_ip"{
  type    = number
  default = 2
}
/*--------------- # NAT Gateway ---------------*/

variable "nat" {
  type    = number
  default = 2
}
variable "nat_tags" {
  type        = list(map(string))
  default = [{
    Name = "frontend-subnet"
    Enviroment = "dev"
    Owner = "shreya"
    }, {
    Name = "database-subnet"
    Enviroment = "dev"
    Owner = "shreya"
  }]
}


/*--------------- # Route Table ---------------*/

variable "public_route_table_tags" {
  type    = map(string)
  default = {
    Name = "dev-public-RTB-01"
    Enviroment = "dev"
    Owner = "shreya"
  }
}

variable "private_route_table_tags" {
  type    = list(map(string))
  default = [{
    Name = "dev-private-RTB-01"
    Enviroment = "dev"
    Owner = "shreya"
  }]
}
variable "specific_subnet_AZ01" {
  type    = list(number)
  default = [0, 2, 4]  
}
variable "specific_subnet_AZ02" {
  type    = list(number)
  default = [1, 3, 5]  
}
/*--------------- Frontend NACL ---------------*/

variable "frontend_nacl_ingress" {
  type    = list(object({
    rule_no = number
    protocol = string
    cidr_block = string
    from_port = number
    to_port = number
    action = string
  }))
}

variable "frontend_nacl_egress" {
  type    = list(object({
    rule_no = number
    protocol = string
    cidr_block = string
    from_port = number
    to_port = number
    action = string
  }))
}

variable "frontend_nacl_tags" {
  type    = map(string)
  default = {
    Name = "dev-frontend-nacl-01"
    Enviroment = "dev"
    Owner = "shreya"
  }
}

/*--------------- Backend NACL ---------------*/

variable "backend_nacl_ingress" {
  type    = list(object({
    rule_no = number
    protocol = string
    cidr_block = string
    from_port = number
    to_port = number
    action = string
  }))
}

variable "backend_nacl_egress" {
  type    = list(object({
    rule_no = number
    protocol = string
    cidr_block = string
    from_port = number
    to_port = number
    action = string
  }))
}

variable "backend_nacl_tags" {
  type    = map(string)
  default = {
    Name = "dev-backend-nacl-01"
    Enviroment = "dev"
    Owner = "shreya"
  }
}

/*--------------- Database NACL ---------------*/

variable "db_nacl_ingress" {
  type    = list(object({
    rule_no = number
    protocol = string
    cidr_block = string
    from_port = number
    to_port = number
    action = string
  }))
}

variable "db_nacl_egress" {
  type    = list(object({
    rule_no = number
    protocol = string
    cidr_block = string
    from_port = number
    to_port = number
    action = string
  }))
}

variable "db_nacl_tags" {
  type    = map(string)
  default = {
    Name = "dev-db-nacl-01"
    Enviroment = "dev"
    Owner = "shreya"
  }
}

/*--------------- ALB Security Group ---------------*/

variable "alb_sg_name" {
  description = "security group name"
  type            = string
  default         = "dev-alb-sg"
}

variable "alb_sg_description" {
  description = "security group for Attendance API"
  type            = string
  default         = "Security group for Dev-ALB"
}

variable "alb_sg_inbound_rules" {
  description = "List of inbound rules for the security group"
  type = list(object({
    port     = number
    source   = string
    protocol = string
  }))
  default = [{
      port     = 80
      source   = "0.0.0.0/0" 
      protocol = "tcp"  
    }, {
      port     = 443
      source   = "0.0.0.0/0" 
      protocol = "tcp"  
    }]
}

variable "alb_sg_outbound_rules" {
  description = "List of outbound rules for the security group"
  type = list(object({
    port     = number
    source   = string
    protocol = string
  }))
  default = [
    {
      port     = 0 // allow all ports 
      source   = "0.0.0.0/0"
      protocol = "-1"  // all protocols
    }
  ]
}

variable "alb_sg_tags" {
  description = "Tag for Attedance sg"
  type        = map(string)
  default     = {
    Environment = "dev"
    Owner       = "shreya"
  }
}

/*--------------- ALB ---------------*/
variable "alb_name" {
  type = string
  default = "dev-alb"
}
variable "alb_internal" {
  type = bool
  default = false 
}
variable "alb_type" {
  type = string
  default = "application"  
}
variable "alb_deletion_protection" {
  type = bool
  default = true
}
variable "alb_tags" {
  type    = map(string)
  default = {
    Enviroment = "dev"
    Owner = "shreya"
  }
}

/*--------------- Listner ---------------*/

variable "alb_listener_port" {
  description = "The port on which the ALB listens for incoming traffic."
  type        = number
}
// expected protocol to be one of ["HTTP" "HTTPS" "TCP" "TLS" "UDP" "TCP_UDP" "GENEVE"]
variable "alb_listener_protocol" {
  description = "The protocol for routing traffic to the target. "
  type        = string
}

/*--------------- Route 53 ---------------*/

variable "route53_zone_tags" {
  type    = map(string)
  default = {
    Enviroment = "dev"
    Owner = "shreya"
  }
}
variable "route53_zone_name" {
  type = string
  default = "example.com"
}

# ************************************ Open VPN ************************************ # 

variable "sec_grp_name" {
  description = "Name for the security group"
  type        = string
  default     = "sg"
}

variable "Sec_grp_description" {
  description = "Description for the security group"
  type        = string
  default     = "Security group for Dev Env"
}


variable "inbound_ports" {
  description = "List of inbound ports, protocols, and CIDR blocks or security group IDs"
  type        = list(map(any))
  default     = [
    { port = 22, protocol = "TCP", cidr_blocks = "20.0.0.0/26" }, 
    { port = 22, protocol = "TCP", security_group_ids = "sg-0c78f907a02b01dd4" },
  ]
}

variable "outbound_ports" {
  description = "List of outbound ports, protocols, and CIDR block"
  type        = list(map(any)) // Ensure cidr_blocks is a list of strings
  default     = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" },
  ]
}

variable "Sec_grp_tags" {
  description = "Tags for the security group"
  type        = map(string)
  default     = {
    Name        = "sg"
    Environment = "dev"
    Owner       = "shreya"
  }
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "server_type" {
  description = "Instance type for standalone server"
  type        = string
}

variable "server_name" {
  description = "Name tag for the standalone server"
  type        = string
  default     = "Standalone-Server"
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 2  
}

variable "associate_public_ip" {
  description = "Association of Public IP"
  type        = bool
  default     = "false"
}  
variable "Env" {
  type = string
  default = "Prod"
}

variable "Owner" {
  type = string
  default = "Vishal"
}

# ************************************ Redis ************************************ # 

variable "redis_sec_grp_name" {
  description = "Name for the security group"
  type        = string
  default     = "sg"
}

variable "redis_Sec_grp_description" {
  description = "Description for the security group"
  type        = string
  default     = "Security group for Dev Env"
}


variable "redis_inbound_ports" {
  description = "List of inbound ports, protocols, and CIDR blocks or security group IDs"
  type        = list(map(any))
  default     = [
    { port = 22, protocol = "TCP", cidr_blocks = "20.0.0.0/26" }, 
    { port = 22, protocol = "TCP", security_group_ids = "sg-0c78f907a02b01dd4" },
  ]
}

variable "redis_outbound_ports" {
  description = "List of outbound ports, protocols, and CIDR block"
  type        = list(map(any)) // Ensure cidr_blocks is a list of strings
  default     = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" },
  ]
}

variable "redis_Sec_grp_tags" {
  description = "Tags for the security group"
  type        = map(string)
  default     = {
    Name        = "sg"
    Environment = "dev"
    Owner       = "shreya"
  }
}

variable "redis_key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "redis_server_type" {
  description = "Instance type for standalone server"
  type        = string
}

variable "redis_server_name" {
  description = "Name tag for the standalone server"
  type        = string
  default     = "Standalone-Server"
}

variable "redis_instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 2  
}

variable "redis_associate_public_ip" {
  description = "Association of Public IP"
  type        = bool
  default     = "false"
}  
variable "redis_Env" {
  type = string
  default = "Prod"
}

variable "redis_Owner" {
  type = string
  default = "Vishal"
}

# ************************************ Postgres ************************************ # 

variable "pgsql_sec_grp_name" {
  description = "Name for the security group"
  type        = string
  default     = "sg"
}

variable "pgsql_Sec_grp_description" {
  description = "Description for the security group"
  type        = string
  default     = "Security group for Dev Env"
}


variable "pgsql_inbound_ports" {
  description = "List of inbound ports, protocols, and CIDR blocks or security group IDs"
  type        = list(map(any))
  default     = [
    { port = 22, protocol = "TCP", cidr_blocks = "20.0.0.0/26" }, 
    { port = 22, protocol = "TCP", security_group_ids = "sg-0c78f907a02b01dd4" },
  ]
}

variable "pgsql_outbound_ports" {
  description = "List of outbound ports, protocols, and CIDR block"
  type        = list(map(any)) // Ensure cidr_blocks is a list of strings
  default     = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" },
  ]
}

variable "pgsql_Sec_grp_tags" {
  description = "Tags for the security group"
  type        = map(string)
  default     = {
    Name        = "sg"
    Environment = "dev"
    Owner       = "shreya"
  }
}

variable "pgsql_key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "pgsql_server_type" {
  description = "Instance type for standalone server"
  type        = string
}

variable "pgsql_server_name" {
  description = "Name tag for the standalone server"
  type        = string
  default     = "Standalone-Server"
}

variable "pgsql_instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 2  
}

variable "pgsql_associate_public_ip" {
  description = "Association of Public IP"
  type        = bool
  default     = "false"
}  
variable "pgsql_Env" {
  type = string
  default = "Prod"
}

variable "pgsql_Owner" {
  type = string
  default = "Vishal"
}

# ************************************ Scylla ************************************ # 

variable "scylla_sec_grp_name" {
  description = "Name for the security group"
  type        = string
  default     = "sg"
}

variable "scylla_Sec_grp_description" {
  description = "Description for the security group"
  type        = string
  default     = "Security group for Dev Env"
}


variable "scylla_inbound_ports" {
  description = "List of inbound ports, protocols, and CIDR blocks or security group IDs"
  type        = list(map(any))
  default     = [
    { port = 22, protocol = "TCP", cidr_blocks = "20.0.0.0/26" }, 
    { port = 22, protocol = "TCP", security_group_ids = "sg-0c78f907a02b01dd4" },
  ]
}

variable "scylla_outbound_ports" {
  description = "List of outbound ports, protocols, and CIDR block"
  type        = list(map(any)) // Ensure cidr_blocks is a list of strings
  default     = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" },
  ]
}

variable "scylla_Sec_grp_tags" {
  description = "Tags for the security group"
  type        = map(string)
  default     = {
    Name        = "sg"
    Environment = "dev"
    Owner       = "shreya"
  }
}

variable "scylla_key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "scylla_server_type" {
  description = "Instance type for standalone server"
  type        = string
}

variable "scylla_server_name" {
  description = "Name tag for the standalone server"
  type        = string
  default     = "Standalone-Server"
}

variable "scylla_instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 2  
}

variable "scylla_associate_public_ip" {
  description = "Association of Public IP"
  type        = bool
  default     = "false"
}  
variable "scylla_Env" {
  type = string
  default = "Prod"
}

variable "scylla_Owner" {
  type = string
  default = "Vishal"
}

