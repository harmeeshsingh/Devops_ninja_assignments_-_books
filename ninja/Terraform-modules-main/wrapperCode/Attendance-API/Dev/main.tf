module"Dev_Attendance" {
source                              = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Auto_Sacling_Module?ref=harshit/rolling-module"
#---------------------------------Security Group ----------------------------------#
security_name                       = var.Dev_Attendance_security_name
Security_description                = var.Dev_Attendance_security_description
SG_vpc_id                           = var.Dev_Attendance_SG_vpc_id
inbound_ports                       = var.Dev_Attendance_inbound_ports
outbound_ports                      = var.Dev_Attendance_outbound_ports
Sg_tags                             = var.Dev_Attendance_Sg_tags
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------
private_key_algorithm               = var.Dev_Attendance_private_key_algorithm
private_key_rsa_bits                = var.Dev_Attendance_private_key_rsa_bits
template_name                       = var.Dev_Attendance_template_name
template_description                = var.Dev_Attendance_template_description
AMI_ID                              = var.Dev_Attendance_AMI_ID
instance_type                       = var.Dev_Attendance_instance_type
instance_keypair                    = var.Dev_Attendance_instance_keypair
subnet_ID                           = var.Dev_Attendance_subnet_ID
user_data_script_path               = var.Dev_Attendance_user_data_script_path
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#
target_group_name                   = var.Dev_Attendance_target_group_name
target_group_port                   = var.Dev_Attendance_target_group_port
target_group_protocol               = var.Dev_Attendance_target_group_protocol
TG_vpc_id                           = var.Dev_Attendance_TG_vpc_id
health_check_path                   = var.Dev_Attendance_health_check_path
health_check_port                   = var.Dev_Attendance_health_check_port
health_check_interval               = var.Dev_Attendance_health_check_interval
health_check_timeout                = var.Dev_Attendance_health_check_timeout
health_check_healthy_threshold      = var.Dev_Attendance_health_check_healthy_threshold
health_check_unhealthy_threshold    = var.Dev_Attendance_health_check_unhealthy_threshold
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#
listener_arn                         = var.Dev_Attendance_listener_arn
path_pattern                         = var.Dev_Attendance_path_pattern
action_type                          = var.Dev_Attendance_action_type
priority                             = var.Dev_Attendance_priority
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#
autoscaling_group_name              = var.Dev_Attendance_autoscaling_group_name
ASG_version                         = var.Dev_Attendance_ASG_vserion
subnet_ids                          = var.Dev_Attendance_subnet_ids
tag_key                             = var.Dev_Attendance_tag_key
tag_value                           = var.Dev_Attendance_tag_value
propagate_at_launch                 = var.Dev_Attendance_propagate_at_launch
min_size                            = var.Dev_Attendance_min_size
max_size                            = var.Dev_Attendance_max_size
desired_capacity                    = var.Dev_Attendance_desired_capacity
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#
scaling_policy_name                 = var.Dev_Attendance_scaling_policy_name
policy_type                         = var.Dev_Attendance_policy_type
predefined_metric_type              = var.Dev_Attendance_predefined_metric_type
target_value                        = var.Dev_Attendance_target_value
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
}
