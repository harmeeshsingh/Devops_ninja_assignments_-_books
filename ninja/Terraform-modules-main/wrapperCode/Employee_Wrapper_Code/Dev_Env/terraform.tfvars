#----------------------------------Security Group -----------------------------------#

Dev_Employee_security_name                       = "Dev-Employee-sg"
Dev_Employee_security_description                = "Security group for Dev-Employee-API"
Dev_Employee_SG_vpc_id                           = "vpc-037273df63a16de65"    #Dev_Employee-VPC-ID
Dev_Employee_inbound_ports                       = [
  { port                                = 22, protocol = "tcp", cidr_blocks = "20.0.0.0/28" },                     # Management VPC Cidr Block
  { port                                = 22, protocol = "tcp", security_group_ids = "sg-04b7eb5f6320a1aa6" },     #  Dev-Employee-lb-sg ID
  { port                                = 8080, protocol = "tcp", security_group_ids = "sg-04b7eb5f6320a1aa6" },   # OpenVPN-SG
]
Dev_Employee_outbound_ports                      = [
  { port                                = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" }
]
Dev_Employee_Sg_tags                             = {
  Name                                  = "Dev-Employee-sg"
  Enviroment                            = "Dev_Employee"
  Owner                                 = "Employee"
}

#---------------------------------Launch Template -----------------------------------#

Dev_Employee_private_key_algorithm               = "RSA"
Dev_Employee_private_key_rsa_bits                = 4096
Dev_Employee_template_name                       = "Dev-Employee-template"
Dev_Employee_template_description                = "Template for Dev-Employee"
Dev_Employee_AMI_ID                              = "ami-08e4b984abde34a4f"
Dev_Employee_instance_type                       = "t2.medium"
Dev_Employee_instance_keypair                    = "Dev_Employee_Key"
Dev_Employee_subnet_ID                           = "subnet-0abcfc7a31b6687b4"
Dev_Employee_user_data_script_path               = "./script.sh"

#---------------------------------- Target Group ------------------------------------#

Dev_Employee_target_group_name                   = "Dev-Employee-TG"
Dev_Employee_target_group_port                   = 8080
Dev_Employee_target_group_protocol               = "HTTP"
Dev_Employee_TG_vpc_id                           = "vpc-037273df63a16de65"   #Dev_Employee-VPC-ID
Dev_Employee_health_check_path                   = "/health"
Dev_Employee_health_check_port                   = "traffic-port"
Dev_Employee_health_check_interval               = 30
Dev_Employee_health_check_timeout                = 5
Dev_Employee_health_check_healthy_threshold      = 2
Dev_Employee_health_check_unhealthy_threshold    = 2

#-------------------------------- Listener rule of ALB ------------------------------#

Dev_Employee_listener_arn                          = "arn:aws:elasticloadbalancing:ap-southeast-1:441247711986:listener/app/dev-employee/6f43a19bab752505/82a2b41cfac4ade3"
Dev_Employee_path_pattern                          = "/api/v1/employee/*"
Dev_Employee_action_type                           = "forward"
Dev_Employee_priority                              = 100

#---------------------------Configure Auto Scaling group ----------------------------#

Dev_Employee_autoscaling_group_name              = "Dev-Employee_ASG"
Dev_Employee_ASG_vserion                         = "$Latest"
Dev_Employee_min_size                            = 1
Dev_Employee_max_size                            = 2
Dev_Employee_desired_capacity                    = 1
Dev_Employee_subnet_ids                          = ["subnet-0abcfc7a31b6687b4"]   #Dev-Employee Pvt ID
Dev_Employee_tag_key                             = "Name"
Dev_Employee_tag_value                           = "Dev-Employee_ASG"
Dev_Employee_propagate_at_launch                 = true

#----------------------------- Auto Scaling Policies --------------------------------#

Dev_Employee_scaling_policy_name                 = "target-tracking-policy"
Dev_Employee_policy_type                         = "TargetTrackingScaling"
Dev_Employee_predefined_metric_type              = "ASGAverageCPUUtilization"
Dev_Employee_target_value                        = 50.0
