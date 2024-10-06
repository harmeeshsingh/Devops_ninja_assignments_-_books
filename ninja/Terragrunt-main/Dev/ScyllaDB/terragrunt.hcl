include "root" {
  path = find_in_parent_folders("common.hcl")
}
terraform {
  source = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/VM-Module?ref=main"
}
inputs = {
    vpc_id          = "vpc-007fd0dab685edb84"
key_name            = "scyllaKey.pem"
server_type         = "t2.micro"
subnet_id           = "subnet-0bb47040eb71fb933"
server_name         = "Dev_Scylla-Server"
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


