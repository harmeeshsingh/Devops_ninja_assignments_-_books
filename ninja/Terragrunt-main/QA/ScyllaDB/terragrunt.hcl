
include "root" {
  path = find_in_parent_folders("common.hcl")
}
terraform {
  source = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/VM-Module?ref=main"
}
inputs = {
    vpc_id          = "vpc-021ba65dc7d757ba2"
key_name            = "scyllaKeyQA.pem"
server_type         = "t2.medium"
subnet_id           = "subnet-0a23407e8cd107029"
server_name         = "QA_Scylla-Server"
inbound_ports = [ {
 port = 22 , protocol = "tcp" , cidr_blocks = "20.0.0.32/28"
} ,
# {
 # port = 22 , protocol = "tcp" , security_group_ids = "sg-0371e4d02f8e34e3c"
# },
# {
 # port = 9042 , protocol = "tcp" , security_group_ids = "sg-0371e4d02f8e34e3c"
# }
]
}
