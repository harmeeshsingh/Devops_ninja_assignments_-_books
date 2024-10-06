vpc-id              = "vpc-0a744f2efc4febb2a"
key-name            = "snaatak.pem"
server-type         = "t2.micro"
subnet-id           = "subnet-009e342da70d1d460"
server-name         = "qa-openvpn-Server"
sec-grp-name        = "qa-openvpn-sg"
Sec-grp-description = "Security group for Open Vpn in QA Env"
inbound-ports       = [
     { port = 22, protocol = "TCP", cidr_blocks = "20.0.0.0/28" }, 
    { port = 1194, protocol = "UDP", cidr_blocks = "0.0.0.0/0" },
]
outbound-ports      = [ 
   { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" },
 ]
