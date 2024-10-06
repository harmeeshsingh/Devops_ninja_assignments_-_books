output "vpc-id" {
  value = aws_vpc.dev_vpc.id
}

output "public-subnets-id" {
  value = aws_subnet.dev_public_subnets.*.id
}


output "private-subnets-id" {
  value = aws_subnet.dev_private_subnets.*.id
}

output "igw-id" {
  value = aws_internet_gateway.dev_igw.id
}

output "nat-id" {
  value = aws_nat_gateway.dev_nat.id
}

output "public-RTB-id" {
  value = aws_route_table.dev_public_rtb.id
}

output "private-RTB-id" {
  value = aws_route_table.dev_private_rtb.id
}

output "frontend-nacl-id" {
  value = aws_network_acl.dev_frontend_nacl.id
}

output "backend-nacl-id" {
  value = aws_network_acl.dev_backend_nacl.id
}

output "db-nacl-id" {
  value = aws_network_acl.dev_db_nacl.id
}

output "alb-sg-id" {
  value = aws_security_group.dev_alb_sg.id  
}

output "alb-dns" {
  value = aws_lb.dev_alb.dns_name
}

output "alb-listener-arn" {
  value = aws_lb_listener.dev_alb_listener.arn
}

output "route53-zone" {
  value = aws_route53_zone.dev_route53_zone.name_servers
}
output "route53-record" {
  value = aws_route53_record.dev_route53_record.name
}
