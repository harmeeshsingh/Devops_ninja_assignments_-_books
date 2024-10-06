output "vpc-id" {
  value = module.network.vpc-id
}

output "public-subnets-id" {
  value = module.network.public-subnets-id
}


output "private-subnets-id" {
  value = module.network.private-subnets-id
}

output "dev-igw-id" {
  value = module.network.dev-igw-id
}

output "dev-nat-id" {
  value = module.network.dev-nat-id
}

output "dev-public-RTB-id" {
  value = module.network.dev-public-RTB-id
}

output "dev-private-RTB-id" {
  value = module.network.dev-private-RTB-id
}

output "dev-frontend-nacl-id" {
  value = module.network.dev-frontend-nacl-id
}

output "dev-backend-nacl-id" {
  value = module.network.dev-backend-nacl-id
}

output "dev-db-nacl-id" {
  value = module.network.dev-db-nacl-id
}

output "alb-sg-id" {
  value = module.network.alb-sg-id  
}

output "dev-alb-dns" {
  value = module.network.dev-alb-dns
}

output "dev-route53-zone" {
  value = module.network.dev-route53-zone
}
output "dev-route53-record" {
  value = module.network.dev-route53-record
}
