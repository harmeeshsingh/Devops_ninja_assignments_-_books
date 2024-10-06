#----------------------------------Security Group -----------------------------------#

QA_Employee_security_name                       = "QA-Employee-sg"
QA_Employee_security_description                = "Security group for QA-Employee-API"
QA_Employee_SG_vpc_id                           = "vpc-037273df63a16de65"    #QA_Employee-VPC-ID
QA_Employee_inbound_ports                       = [
  { port                                = 22, protocol = "tcp", cidr_blocks = "20.0.0.0/28" },                     # Management VPC Cidr Block
  { port                                = 22, protocol = "tcp", security_group_ids = "sg-04b7eb5f6320a1aa6" },     #  QA-Employee-lb-sg ID
  { port                                = 8080, protocol = "tcp", security_group_ids = "sg-04b7eb5f6320a1aa6" },   # OpenVPN-SG
]
QA_Employee_outbound_ports                      = [
  { port                                = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" }
]
QA_Employee_Sg_tags                             = {
  Name                                  = "QA-Employee-sg"
  Enviroment                            = "QA_Employee"
  Owner                                 = "Employee"
}

#---------------------------------Launch Template -----------------------------------#

QA_Employee_private_key_algorithm               = "RSA"
QA_Employee_private_key_rsa_bits                = 4096
QA_Employee_template_name                       = "QA-Employee-template"
QA_Employee_template_description                = "Template for QA-Employee"
QA_Employee_AMI_ID                              = "ami-08e4b984abde34a4f"
QA_Employee_instance_type                       = "t2.medium"
QA_Employee_instance_keypair                    = "QA_Employee_Key"
QA_Employee_subnet_ID                           = "subnet-0abcfc7a31b6687b4"
QA_Employee_user_data_script_path               = "./script.sh"

#---------------------------------- Target Group ------------------------------------#

QA_Employee_target_group_name                   = "QA-Employee-TG"
QA_Employee_target_group_port                   = 8080
QA_Employee_target_group_protocol               = "HTTP"
QA_Employee_TG_vpc_id                           = "vpc-037273df63a16de65"   #QA_Employee-VPC-ID
QA_Employee_health_check_path                   = "/health"
QA_Employee_health_check_port                   = "traffic-port"
QA_Employee_health_check_interval               = 30
QA_Employee_health_check_timeout                = 5
QA_Employee_health_check_healthy_threshold      = 2
QA_Employee_health_check_unhealthy_threshold    = 2

#-------------------------------- Listener rule of ALB ------------------------------#

QA_Employee_listener_arn                          = "arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:listener/app/emp-qa/35838b69cfc8ee74/995c5bfc07cb4270"
QA_Employee_path_pattern                          = "/api/v1/employee/*"
QA_Employee_action_type                           = "forward"
QA_Employee_priority                              = 100

#---------------------------Configure Auto Scaling group ----------------------------#

QA_Employee_autoscaling_group_name              = "QA-Employee_ASG"
QA_Employee_ASG_vserion                         = "$Latest"
QA_Employee_min_size                            = 1
QA_Employee_max_size                            = 2
QA_Employee_desired_capacity                    = 1
QA_Employee_subnet_ids                          = ["subnet-0abcfc7a31b6687b4"]   #QA-Employee Pvt ID
QA_Employee_tag_key                             = "Name"
QA_Employee_tag_value                           = "QA-Employee_ASG"
QA_Employee_propagate_at_launch                 = true

#----------------------------- Auto Scaling Policies --------------------------------#

QA_Employee_scaling_policy_name                 = "target-tracking-policy"
QA_Employee_policy_type                         = "TargetTrackingScaling"
QA_Employee_predefined_metric_type              = "ASGAverageCPUUtilization"
QA_Employee_target_value                        = 50.0
