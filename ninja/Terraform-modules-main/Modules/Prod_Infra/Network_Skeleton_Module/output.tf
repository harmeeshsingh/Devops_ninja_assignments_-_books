

output "vpc-id" {
  value = aws_vpc.vpc.id
}

output "public-subnets-id" {
  value = aws_subnet.public_subnets[*].id
}


output "private-subnets-id" {
  value = aws_subnet.private_subnets[*].id
}

output "igw-id" {
  value = aws_internet_gateway.igw.id
}

output "nat-id" {
  value = aws_nat_gateway.nat[*].id
}

output "public-RTB-id" {
  value = aws_route_table.public_rtb.id
}

output "private-RTB-id" {
  value = aws_route_table.private_rtb[*].id
}

output "frontend-nacl-id" {
  value = aws_network_acl.frontend_nacl.id
}

output "backend-nacl-id" {
  value = aws_network_acl.backend_nacl.id
}

output "db-nacl-id" {
  value = aws_network_acl.db_nacl.id
}

output "alb-sg-id" {
  value = aws_security_group.alb_sg.id
}

output "alb-dns" {
  value = aws_lb.alb.dns_name
}

output "alb-listener-arn" {
  value = aws_lb_listener.alb_listener.arn
}

output "route53-zone" {
  value = aws_route53_zone.route53_zone.name_servers
}
output "route53-record" {
  value = aws_route53_record.route53_record.name
}
