include "root" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/VM-Module?ref=main"  

}

inputs = {
    instance_count      = 1
    associate_public_ip = false
    vpc_id              = "vpc-021ba65dc7d757ba2"
    key_name            = "postgresql-qa.pem"
    server_type         = "t2.medium"
    subnet_id           = "subnet-0a23407e8cd107029"
    sec_grp_name = "PostgreSQL-QA-SG"
    sec_grp_tags = {
        Name          = "PostgreSQL-SG"
        Enviroment    = "QA"
        Type          = "postgres"
        Owner         = "Harshit"
    }
    server_name         = "Postgres-Dev"
    inbound_ports = [{
    port = 22 , protocol = "tcp" , cidr_blocks = "20.0.0.0/28"
    },  
    # {
    # port = 22 , protocol = "tcp" , security_group_ids = "sg-0ced15d988acdb94b" will add id when available
    # },
    # {
    # port = 5432 , protocol = "tcp" , security_group_ids = "sg-0a4ecb0570e13e365" will add id when available
    # },
    ]
}
