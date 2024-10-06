vpc-id              = "vpc-0624da13cb0782e79"
key-name            = "efkServerKey"
server-type         = "t2.medium"
subnet-id           = "subnet-0585fe1af0dbe43ec"
sec-grp-name = "efk-sg"
sec-grp-tags = {
    Name          = "efk-sg"
    Enviroment    = "Management"
    Owner         = "Aakash"
}
server-name         = "EFK Server"
inbound-ports = [ {
  port = 9880 , protocol = "tcp" , security_group_ids = "sg-01bebc628cc635081"
},
{
 port = 9200 , protocol = "tcp" , security_group_ids = "sg-01bebc628cc635081"
},
{
 port = 5601 , protocol = "tcp" , security_group_ids = "sg-01bebc628cc635081"
},
{
 port = 24224 , protocol = "tcp" , cidr_blocks = "10.0.0.0/25"
},
{
 port = 24224 , protocol = "tcp" , cidr_blocks = "10.1.0.0/25"
},
{
 port = 22 , protocol = "tcp" , cidr_blocks = "0.0.0.0/0"
}
]
