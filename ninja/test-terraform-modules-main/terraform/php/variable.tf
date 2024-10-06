variable "vpc_cidr1" {
  type = string

  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type = string

  default = "dev-vpc"
}

variable "cidr_subnet1" {
  type = string

  default = "10.0.1.0/24"
}

variable "subnet_zone1" {
  type = string

  default = "us-east-1a"
}
variable "private_subnet_cidr1" {
  type = list(string)
  default = ["10.0.5.0/24","10.0.7.0/24" , "10.0.8.0/24"]
}

variable "private-az_zone1" {
  type = list(string)
  default = ["us-east-1a" , "us-east-1b" , "us-east-1b"]
}
variable "private-subnet-name1" {
  type = list(string)
  default = ["pvt-sub-1a" , "pvt-sub-1b", "pvt-sub2-1b"]
  
}

variable "rt_cidr1" {
  type    = string
  default = "0.0.0.0/0"
}

variable "ports1" {
  type    = list(number)
  default = [22, 80, 443, 5601, 9200]
}

variable "name1" {
  type    = string
  default = "jenkins-sg"
}




variable "static1" {
  type = map(any)
  default = {
    ami      = "ami-053b0d53c279acc90"
    publicip = true
    keyname  = "ohio"
    itype    = "t2.medium"
  }
}

variable "public_name1" {
  type    = string
  default = "bastion"
}

