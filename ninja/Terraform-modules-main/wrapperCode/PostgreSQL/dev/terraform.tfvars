vpc-id              = "vpc-0a744f2efc4febb2a"
key-name            = "postgres.pem"
server-type         = "t2.medium"
subnet-id           = "subnet-0dc05fffbacb821e8"
sec-grp-name = "Postgresqll-sg"
sec-grp-tags = {
    Name          = "Postgresqll-sg"
    Enviroment    = "Dev"
    Owner         = "Vikram"
}
server-name         = "Postgres-Dev"
inbound-ports = [ {
  port = 22 , protocol = "tcp" , security_group_ids = "sg-0ced15d988acdb94b" 
},
{
 port = 5432 , protocol = "tcp" , security_group_ids = "sg-0a4ecb0570e13e365"
},
{
 port = 22 , protocol = "tcp" , cidr_blocks = "20.0.0.0/28"
} ]
