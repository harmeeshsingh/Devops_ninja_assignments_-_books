vpc_cidr1         = "10.0.0.0/16"
vpc_name          = "dev-vpc"
cidr_subnet1      = "10.0.1.0/24"
subnet_zone1      = "us-east-1a"
private_subnet_cidr1 = ["10.0.5.0/24", "10.0.7.0/24", "10.0.8.0/24"]
private-az_zone1  = ["us-east-1a", "us-east-1b", "us-east-1b"]
private-subnet-name1 = ["pvt-sub-1a", "pvt-sub-1b", "pvt-sub2-1b"]
rt_cidr1          = "0.0.0.0/0"
ports1            = [22, 80, 443, 5601, 9200]
name1             = "jenkins-sg"

static1 = {
  ami      = "ami-053b0d53c279acc90"
  publicip = true
  keyname  = "ohio"
  itype    = "t2.medium"
}

public_name1      = "bastion"
