module "openvpn" {
    source                         = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/VM-Module?ref=main"  
    vpc_id                         = var.vpc-id 
    subnet_id                      = var.subnet-id         
    sec_grp_name                   = var.sec-grp-name
    Sec_grp_description            = var.Sec-grp-description
    inbound_ports                  = var.inbound-ports
    outbound_ports                 = var.outbound-ports
    Sec_grp_tags                   = var.Sec-grp-tags
    key_name                       = var.key-name
    server_type                    = var.server-type
    server_name                    = var.server-name
}    
