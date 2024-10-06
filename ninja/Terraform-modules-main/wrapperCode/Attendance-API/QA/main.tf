#---------------------------------Security Group ----------------------------------#
module "QA_Attendance" {
  source               = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Auto_Sacling_Module?ref=main"
  security_name        = var.security_name
  Security_description = var.security_description
  SG_vpc_id            = var.vpc_id
  inbound_ports        = var.inbound_ports
  outbound_ports       = var.outbound_ports
  Sg_tags              = var.Sg_tags


  #--------------------------------Launch Template ----------------------------------
  private_key_algorithm = var.private_key_algorithm
  private_key_rsa_bits  = var.private_key_rsa_bits
  template_name         = var.template_name
  template_description  = var.template_description
  AMI_ID                = var.AMI_ID
  instance_type         = var.instance_type
  instance_keypair      = var.instance_keypair
  subnet_ID             = var.subnet_ID
  user_data_script_path = var.user_data_script_path


  #--------------------------------- Target Group -----------------------------------#
  target_group_name                = var.target_group_name
  target_group_port                = var.target_group_port
  target_group_protocol            = var.target_group_protocol
  TG_vpc_id                        = var.TG_vpc_id
  health_check_path                = var.health_check_path
  health_check_port                = var.health_check_port
  health_check_interval            = var.health_check_interval
  health_check_timeout             = var.health_check_timeout
  health_check_healthy_threshold   = var.health_check_healthy_threshold
  health_check_unhealthy_threshold = var.health_check_unhealthy_threshold


  #------------------------------- Listener rule of ALB -----------------------------#
  listener_arn = var.listener_arn
  path_pattern = var.path_pattern
  action_type  = var.action_type
  priority     = var.priority


  #--------------------------Configure Auto Scaling group ---------------------------#
  autoscaling_group_name = var.autoscaling_group_name
  ASG_version            = var.ASG_version
  subnet_ids             = var.subnet_ids
  tag_key                = var.tag_key
  tag_value              = var.tag_value
  propagate_at_launch    = var.propagate_at_launch
  min_size               = var.min_size
  max_size               = var.max_size
  desired_capacity       = var.desired_capacity


  #---------------------------- Auto Scaling Policies -------------------------------#
  scaling_policy_name    = var.scaling_policy_name
  policy_type            = var.policy_type
  predefined_metric_type = var.predefined_metric_type
  target_value           = var.target_value
}
