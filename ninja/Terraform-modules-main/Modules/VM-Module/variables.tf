variable "sec_grp_name" {
  description = "Name for the security group"
  type        = string
  default     = "dev_sg"
}

variable "Sec_grp_description" {
  description = "Description for the security group"
  type        = string
  default     = "Security group for Dev Env"
}

variable "vpc_id" {
  description = "ID of the VPC for instances"
  type        = string
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
    Name        = "dev_sg"
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

variable "subnet_id" {
  description = "ID of the subnet for the standalone server"
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
