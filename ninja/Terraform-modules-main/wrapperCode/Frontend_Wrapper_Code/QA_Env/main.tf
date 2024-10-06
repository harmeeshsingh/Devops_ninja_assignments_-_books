module "QA_Frontend" {
source                              = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Auto_Sacling_Module?ref=main"
#---------------------------------Security Group ----------------------------------#
security_name                       = var.QA_Frontend_security_name
Security_description                = var.QA_Frontend_security_description
SG_vpc_id                           = var.QA_Frontend_SG_vpc_id
inbound_ports                       = var.QA_Frontend_inbound_ports
outbound_ports                      = var.QA_Frontend_outbound_ports
Sg_tags                             = var.QA_Frontend_Sg_tags
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------
private_key_algorithm               = var.QA_Frontend_private_key_algorithm
private_key_rsa_bits                = var.QA_Frontend_private_key_rsa_bits
template_name                       = var.QA_Frontend_template_name
template_description                = var.QA_Frontend_template_description
AMI_ID                              = var.QA_Frontend_AMI_ID
instance_type                       = var.QA_Frontend_instance_type
instance_keypair                    = var.QA_Frontend_instance_keypair
subnet_ID                           = var.QA_Frontend_subnet_ID
user_data_script_path               = var.QA_Frontend_user_data_script_path
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#
target_group_name                   = var.QA_Frontend_target_group_name
target_group_port                   = var.QA_Frontend_target_group_port
target_group_protocol               = var.QA_Frontend_target_group_protocol
TG_vpc_id                           = var.QA_Frontend_TG_vpc_id
health_check_path                   = var.QA_Frontend_health_check_path
health_check_port                   = var.QA_Frontend_health_check_port
health_check_interval               = var.QA_Frontend_health_check_interval
health_check_timeout                = var.QA_Frontend_health_check_timeout
health_check_healthy_threshold      = var.QA_Frontend_health_check_healthy_threshold
health_check_unhealthy_threshold    = var.QA_Frontend_health_check_unhealthy_threshold
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#
listener_arn                         = var.QA_Frontend_listener_arn
path_pattern                         = var.QA_Frontend_path_pattern
action_type                          = var.QA_Frontend_action_type
priority                             = var.QA_Frontend_priority
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#
autoscaling_group_name              = var.QA_Frontend_autoscaling_group_name
ASG_version                         = var.QA_Frontend_ASG_vserion
subnet_ids                          = var.QA_Frontend_subnet_ids
tag_key                             = var.QA_Frontend_tag_key
tag_value                           = var.QA_Frontend_tag_value
propagate_at_launch                 = var.QA_Frontend_propagate_at_launch
min_size                            = var.QA_Frontend_min_size
max_size                            = var.QA_Frontend_max_size
desired_capacity                    = var.QA_Frontend_desired_capacity
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#
scaling_policy_name                 = var.QA_Frontend_scaling_policy_name
policy_type                         = var.QA_Frontend_policy_type
predefined_metric_type              = var.QA_Frontend_predefined_metric_type
target_value                        = var.QA_Frontend_target_value
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
}
