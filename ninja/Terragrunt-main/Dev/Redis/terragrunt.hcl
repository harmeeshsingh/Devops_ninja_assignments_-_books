include "root" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/VM-Module?ref=main"  

}

inputs = {
    vpc_id          = "vpc-0a744f2efc4febb2a"
key_name            = "redisKey.pem"
server_type         = "t2.medium"
subnet_id           = "subnet-0dc05fffbacb821e8"
server_name         = "Dev_Redis-Server"
inbound_ports = [ {
  port = 22 , protocol = "tcp" , security_group_ids = "sg-0ced15d988acdb94b" 
},
{
 port = 6379 , protocol = "tcp" , security_group_ids = "sg-0a4ecb0570e13e365"
},
{
 port = 22 , protocol = "tcp" , cidr_blocks = "20.0.0.0/28"
} ]
}
