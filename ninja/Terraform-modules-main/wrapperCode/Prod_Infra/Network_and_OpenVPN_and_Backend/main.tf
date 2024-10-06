module "network" {
  source                         = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Prod_Infra/Network_Skeleton_Module?ref=vishal/Prod-Infra-tf"
  region                         = var.region
  vpc_cidr                       = var.vpc_cidr
  vpc_tags                       = var.vpc_tags
  vpc_enable_dns_support         = var.vpc_enable_dns_support
  vpc_enable_dns_hostnames       = var.vpc_enable_dns_hostnames
  public_subnets_cidr            = var.public_subnets_cidr
  aws_region                     = var.aws_region
  elastic_ip                     = var.elastic_ip
  enable_map_public_ip_on_launch = var.enable_map_public_ip_on_launch
  public_subnets_tags            = var.public_subnets_tags
  private_subnets_cidr           = var.private_subnets_cidr
  private_subnets_tags           = var.private_subnets_tags
  igw_tags                       = var.igw_tags
  nat                            = var.nat 
  nat_tags                       = var.nat_tags
  public_route_table_tags        = var.public_route_table_tags
  private_route_table_tags       = var.private_route_table_tags
  specific_subnet_AZ01           = var.specific_subnet_AZ01
  specific_subnet_AZ02           = var.specific_subnet_AZ02     
  frontend_nacl_ingress          = var.frontend_nacl_ingress
  frontend_nacl_egress           = var.frontend_nacl_egress
  frontend_nacl_tags             = var.frontend_nacl_tags
  backend_nacl_ingress           = var.backend_nacl_ingress
  backend_nacl_egress            = var.backend_nacl_egress
  backend_nacl_tags              = var.backend_nacl_tags
  db_nacl_ingress                = var.db_nacl_ingress
  db_nacl_egress                 = var.db_nacl_egress
  db_nacl_tags                   = var.db_nacl_tags
  alb_sg_name                    = var.alb_sg_name
  alb_sg_description             = var.alb_sg_description
  alb_sg_inbound_rules           = var.alb_sg_inbound_rules
  alb_sg_outbound_rules          = var.alb_sg_outbound_rules
  alb_sg_tags                    = var.alb_sg_tags
  alb_name                       = var.alb_name
  alb_internal                   = var.alb_internal
  alb_type                       = var.alb_type
  alb_deletion_protection        = var.alb_deletion_protection
  alb_tags                       = var.alb_tags
  alb_listener_port              = var.alb_listener_port
  alb_listener_protocol          = var.alb_listener_protocol
  route53_zone_tags              = var.route53_zone_tags
  route53_zone_name              = var.route53_zone_name
}


module "Openvpn" {
    source                         = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Prod_Infra/VM_Modules?ref=vishal/Prod-Infra-tf"  
    vpc_id                         = module.network.vpc-id
    subnet_id                      = [module.network.public-subnets-id["0"], module.network.public-subnets-id["1"]]
    sec_grp_name                   = var.sec_grp_name
    Sec_grp_description            = var.Sec_grp_description
    inbound_ports                  = var.inbound_ports
    outbound_ports                 = var.outbound_ports
    Sec_grp_tags                   = var.Sec_grp_tags
    key_name                       = var.key_name
    server_type                    = var.server_type
    server_name                    = var.server_name
    associate_public_ip            = var.associate_public_ip
    Env                            = var.Env
    Owner                          = var.Owner
}  

module "Redis" {
    source                         = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Prod_Infra/VM_Modules?ref=vishal/Prod-Infra-tf"
    vpc_id                         = module.network.vpc-id
    subnet_id                      = [module.network.private-subnets-id["4"], module.network.private-subnets-id["5"]]
    sec_grp_name                   = var.redis_sec_grp_name
    Sec_grp_description            = var.redis_Sec_grp_description
    inbound_ports                  = var.redis_inbound_ports
    outbound_ports                 = var.redis_outbound_ports
    Sec_grp_tags                   = var.redis_Sec_grp_tags
    key_name                       = var.redis_key_name
    server_type                    = var.redis_server_type
    server_name                    = var.redis_server_name
    associate_public_ip            = var.redis_associate_public_ip
    Env                            = var.redis_Env
    Owner                          = var.redis_Owner
}  
module "Postgresql" {
    source                         = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Prod_Infra/VM_Modules?ref=vishal/Prod-Infra-tf"
    vpc_id                         = module.network.vpc-id
    subnet_id                      = [module.network.private-subnets-id["4"], module.network.private-subnets-id["5"]]
    sec_grp_name                   = var.pgsql_sec_grp_name
    Sec_grp_description            = var.pgsql_Sec_grp_description
    inbound_ports                  = var.pgsql_inbound_ports
    outbound_ports                 = var.pgsql_outbound_ports
    Sec_grp_tags                   = var.pgsql_Sec_grp_tags
    key_name                       = var.pgsql_key_name
    server_type                    = var.pgsql_server_type
    server_name                    = var.pgsql_server_name
    associate_public_ip            = var.pgsql_associate_public_ip
    Env                            = var.pgsql_Env
    Owner                          = var.pgsql_Owner
}  

module "Scylla" {
    source                         = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Prod_Infra/VM_Modules?ref=vishal/Prod-Infra-tf"
    vpc_id                         = module.network.vpc-id
    subnet_id                      = [module.network.private-subnets-id["4"], module.network.private-subnets-id["5"]]
    sec_grp_name                   = var.scylla_sec_grp_name
    Sec_grp_description            = var.scylla_Sec_grp_description
    inbound_ports                  = var.scylla_inbound_ports
    outbound_ports                 = var.scylla_outbound_ports
    Sec_grp_tags                   = var.scylla_Sec_grp_tags
    key_name                       = var.scylla_key_name
    server_type                    = var.scylla_server_type
    server_name                    = var.scylla_server_name
    associate_public_ip            = var.scylla_associate_public_ip
    Env                            = var.scylla_Env
    Owner                          = var.scylla_Owner
}  
