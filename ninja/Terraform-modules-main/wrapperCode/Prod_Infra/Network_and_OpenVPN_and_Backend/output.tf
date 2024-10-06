# ************************************ Netwrok ************************************ # 

output "vpc-id" {
  value = module.network.vpc-id
}

output "public-subnets-id" {
  value = module.network.public-subnets-id
}


output "private-subnets-id" {
  value = module.network.private-subnets-id
}

output "igw-id" {
  value = module.network.igw-id
}

output "nat-id" {
  value = module.network.nat-id
}

output "public-RTB-id" {
  value = module.network.public-RTB-id
}

output "private-RTB-id" {
  value = module.network.private-RTB-id
}

output "frontend-nacl-id" {
  value = module.network.frontend-nacl-id
}

output "backend-nacl-id" {
  value = module.network.backend-nacl-id
}

output "db-nacl-id" {
  value = module.network.db-nacl-id
}

output "alb-sg-id" {
  value = module.network.alb-sg-id
}

output "alb-dns" {
  value = module.network.alb-dns
}

output "route53-zone" {
  value = module.network.route53-zone
}
output "route53-record" {
  value = module.network.route53-record
}

output "alb-listener-arn" {
  value = module.network.alb-listener-arn
}

# ************************************ Open VPN ************************************ # 

output "Open_VPN_Security_Group_ID" {
  value = module.Openvpn.Security_Group_ID
}
output "Open_VPN_server_id" {
  value = module.Openvpn.server_id
}

# ************************************ Redis ************************************ # 


output "Redis_Security_Group_ID" {
  value = module.Redis.Security_Group_ID
}
output "Redis_server_id" {
  value = module.Redis.server_id
}

# ************************************ Postgresql ************************************ # 


output "Pgsql_Security_Group_ID" {
  value = module.Postgresql.Security_Group_ID
}
output "Pgsql_server_id" {
  value = module.Postgresql.server_id
}

# ************************************ Scylla ************************************ # 


output "Scylla_Security_Group_ID" {
  value = module.Scylla.Security_Group_ID
}
output "Scylla_server_id" {
  value = module.Scylla.server_id
}
