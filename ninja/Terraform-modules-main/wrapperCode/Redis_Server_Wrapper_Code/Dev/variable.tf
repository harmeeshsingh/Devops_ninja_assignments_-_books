variable "sec-grp-name" {
  description     = "Name of the security group"
  type            = string
  default         = "redis-sg"
}
variable "sec-grp-description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for Redis in Dev Env"
}
variable "vpc-id" {
  description     = "ID of the VPC for instances"
  type            = string
}

variable "inbound-ports" {
  description     = "List of inbound ports, protocols and cidr block"
  type            = list(map(any))
  default         = [
    { port = 22, protocol = "TCP",cidr_blocks = "20.0.0.0/28" },  
    { port = 1194, protocol = "UDP",cidr_blocks = "0.0.0.0/0"},
  ]
}

variable "outbound-ports" {
  description     = "List of outbound ports, protocols and CIDR block "
  type            = list(map(any))
  default         = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "sec-grp-tags" {
  type            = map(string)
  default         = {
    Name          = "redis-sg"
    Enviroment    = "Dev"
    Owner         = "Aakash"
  }
}

variable "key-name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "server-type" {
  description = "Instance type for redis server"
  type        = string
}

variable "subnet-id" {
  description = "Id of the subnet for the redis server"
  type        = string
}

variable "server-name" {
  description = "Name tag for the redis server"
  type        = string
}