#---------------------------------Security Group ----------------------------------#

Dev_Salary_security_name                       = "Dev_Salary-sg"
Dev_Salary_security_description                = "Security group for Dev_Salary-API"
Dev_Salary_SG_vpc_id                           = "vpc-007fd0dab685edb84"    #Dev-VPC-ID
Dev_Salary_inbound_ports                       = [
  { port                                = 22, protocol = "tcp", cidr_blocks = "20.0.0.0/28" },                     # Management VPC Cidr Block
  { port                                = 22, protocol = "tcp", security_group_ids = "sg-039bbfdb5098c77e5" },     #OpenVPN
  { port                                = 8080, protocol = "tcp", security_group_ids = "sg-0daf8fbea6901da24" },   #Lb-sg
]
Dev_Salary_outbound_ports                      = [
  { port                                = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" }
]
Dev_Salary_Sg_tags                             = {
  Name                                  = "Dev_Salary-sg"
  Enviroment                            = "Dev_Salary"
  Owner                                 = "Vishal"
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

Dev_Salary_private_key_algorithm               = "RSA"
Dev_Salary_private_key_rsa_bits                = 4096
Dev_Salary_template_name                       = "Dev_Salary-template"
Dev_Salary_template_description                = "Template for Dev_Salary"
Dev_Salary_AMI_ID                              = "ami-059b22fedfcb93a25"
Dev_Salary_instance_type                       = "t2.medium"
Dev_Salary_instance_keypair                    = "Dev_Salary_Key"
Dev_Salary_subnet_ID                           = "subnet-09fcc50eed3fadec9"
Dev_Salary_user_data_script_path               = "./script.sh"

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

Dev_Salary_target_group_name                   = "Dev-Salary-TG"
Dev_Salary_target_group_port                   = 8080
Dev_Salary_target_group_protocol               = "HTTP"
Dev_Salary_TG_vpc_id                           = "vpc-007fd0dab685edb84"   #Dev-VPC-ID
Dev_Salary_health_check_path                   = "/health"
Dev_Salary_health_check_port                   = "traffic-port"
Dev_Salary_health_check_interval               = 30
Dev_Salary_health_check_timeout                = 5
Dev_Salary_health_check_healthy_threshold      = 2
Dev_Salary_health_check_unhealthy_threshold    = 2

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

Dev_Salary_listener_arn                          = "arn:aws:elasticloadbalancing:us-east-1:630493305452:listener/app/dev-alb/fcb19c22029dc5f1/0abbb0321524949c"
Dev_Salary_path_pattern                          = "/api/v1/salary/*"
Dev_Salary_action_type                           = "forward"
Dev_Salary_priority                              = 105

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

Dev_Salary_autoscaling_group_name              = "Dev_Salary_ASG"
Dev_Salary_ASG_vserion                         = "2"
Dev_Salary_min_size                            = 1
Dev_Salary_max_size                            = 2
Dev_Salary_desired_capacity                    = 1
Dev_Salary_subnet_ids                          = ["subnet-09fcc50eed3fadec9" ]   #Dev_Salary Pvt ID
Dev_Salary_tag_key                             = "Name"
Dev_Salary_tag_value                           = "Dev_Salary"
Dev_Salary_propagate_at_launch                 = true

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

Dev_Salary_scaling_policy_name                 = "target-tracking-policy"
Dev_Salary_policy_type                         = "TargetTrackingScaling"
Dev_Salary_predefined_metric_type              = "ASGAverageCPUUtilization"
Dev_Salary_target_value                        = 50.0

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
