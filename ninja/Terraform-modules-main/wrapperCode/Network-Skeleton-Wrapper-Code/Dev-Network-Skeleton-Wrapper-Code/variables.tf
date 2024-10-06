variable "region" {
  type    = string
  default = "us-east-2"
}
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
  type = map(string)
  default = {
    Name       = "dev-vpc"
    Enviroment = "dev"
    Owner      = "shreya"
  }
}

/*--------------- Public Subnets ---------------*/

variable "public_subnets_cidr" {
  description = "public subnet cidr block"
  type        = list(string)
  default     = ["10.0.1.0/28", "10.0.1.64/28"]

}

variable "public_subnets_az" {
  description = "public subnet availability zones"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b"]
}
variable "enable_map_public_ip_on_launch" {
  type    = bool
  default = true
}

variable "public_subnets_tags" {
  description = "public subnet tags"
  type        = list(map(string))
  default = [{
    Name       = "public-subnet-01"
    Enviroment = "dev"
    Owner      = "shreya"
    }, {
    Name       = "public-subnet-02"
    Enviroment = "dev"
    Owner      = "shreya"
  }]
}

/*--------------- Private Subnets ---------------*/

variable "private_subnets_cidr" {
  description = "private subnet cidr block"
  type        = list(string)
  default     = ["10.0.1.16/28", "10.0.1.32/28", "10.0.1.48/28"]

}

variable "private_subnets_az" {
  description = "private subnet availability zones"
  type        = string
  default     = "us-east-2a"

}

variable "private_subnets_tags" {
  description = "private subnet tags"
  type        = list(map(string))
  default = [{
    Name       = "frontend-subnet"
    Enviroment = "dev"
    Owner      = "shreya"
    }, {
    Name       = "backend-subnet"
    Enviroment = "dev"
    Owner      = "shreya"
    }, {
    Name       = "database-subnet"
    Enviroment = "dev"
    Owner      = "shreya"
  }]
}

/*--------------- # Internet Gateway ---------------*/

variable "igw_tags" {
  type = map(string)
  default = {
    Name       = "dev-igw-01"
    Enviroment = "dev"
    Owner      = "shreya"
  }
}

/*--------------- # NAT Gateway ---------------*/

variable "nat_tags" {
  type = map(string)
  default = {
    Name       = "dev-nat-01"
    Enviroment = "dev"
    Owner      = "shreya"
  }
}

/*--------------- # Route Table ---------------*/

variable "public_route_table_tags" {
  type = map(string)
  default = {
    Name       = "dev-public-RTB-01"
    Enviroment = "dev"
    Owner      = "shreya"
  }
}

variable "private_route_table_tags" {
  type = map(string)
  default = {
    Name       = "dev-private-RTB-01"
    Enviroment = "dev"
    Owner      = "shreya"
  }
}

/*--------------- Frontend NACL ---------------*/

variable "frontend_nacl_ingress" {
  type = list(object({
    rule_no    = number
    protocol   = string
    cidr_block = string
    from_port  = number
    to_port    = number
    action     = string
  }))
}

variable "frontend_nacl_egress" {
  type = list(object({
    rule_no    = number
    protocol   = string
    cidr_block = string
    from_port  = number
    to_port    = number
    action     = string
  }))
}

variable "frontend_nacl_tags" {
  type = map(string)
  default = {
    Name       = "dev-frontend-nacl-01"
    Enviroment = "dev"
    Owner      = "shreya"
  }
}

/*--------------- Backend NACL ---------------*/

variable "backend_nacl_ingress" {
  type = list(object({
    rule_no    = number
    protocol   = string
    cidr_block = string
    from_port  = number
    to_port    = number
    action     = string
  }))
}

variable "backend_nacl_egress" {
  type = list(object({
    rule_no    = number
    protocol   = string
    cidr_block = string
    from_port  = number
    to_port    = number
    action     = string
  }))
}

variable "backend_nacl_tags" {
  type = map(string)
  default = {
    Name       = "dev-backend-nacl-01"
    Enviroment = "dev"
    Owner      = "shreya"
  }
}

/*--------------- Database NACL ---------------*/

variable "db_nacl_ingress" {
  type = list(object({
    rule_no    = number
    protocol   = string
    cidr_block = string
    from_port  = number
    to_port    = number
    action     = string
  }))
}

variable "db_nacl_egress" {
  type = list(object({
    rule_no    = number
    protocol   = string
    cidr_block = string
    from_port  = number
    to_port    = number
    action     = string
  }))
}

variable "db_nacl_tags" {
  type = map(string)
  default = {
    Name       = "dev-db-nacl-01"
    Enviroment = "dev"
    Owner      = "shreya"
  }
}

/*--------------- ALB Security Group ---------------*/

variable "alb_sg_name" {
  description = "security group name"
  type        = string
  default     = "dev-alb-sg"
}

variable "alb_sg_description" {
  description = "security group for Attendance API"
  type        = string
  default     = "Security group for Dev-ALB"
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
      protocol = "-1" // all protocols
    }
  ]
}

variable "alb_sg_tags" {
  description = "Tag for Attedance sg"
  type        = map(string)
  default = {
    Environment = "dev"
    Owner       = "shreya"
  }
}

/*--------------- ALB ---------------*/
variable "alb_name" {
  type    = string
  default = "dev-alb"
}
variable "alb_internal" {
  type    = bool
  default = false
}
variable "alb_type" {
  type    = string
  default = "application"
}
variable "alb_deletion_protection" {
  type    = bool
  default = true
}
variable "alb_tags" {
  type = map(string)
  default = {
    Enviroment = "dev"
    Owner      = "shreya"
  }
}

/*--------------- Listner ---------------*/

variable "alb_listener_port" {
  description = "The port on which the ALB listens for incoming traffic."
  type        = number
}

variable "alb_listener_protocol" {
  description = "The protocol for routing traffic to the target."
  type        = string
}

/*--------------- Route 53 ---------------*/

variable "route53_zone_tags" {
  type = map(string)
  default = {
    Enviroment = "dev"
    Owner      = "shreya"
  }
}
variable "route53_zone_name" {
  type    = string
  default = "example.com"
}
