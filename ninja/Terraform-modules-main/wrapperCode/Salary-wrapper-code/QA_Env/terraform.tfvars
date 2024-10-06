#---------------------------------Security Group ----------------------------------#

QA_Salary_security_name                       = "QA-Salary-sg"
QA_Salary_security_description                = "Security group for QA-Salary-API"
QA_Salary_SG_vpc_id                           = "vpc-00631f1bf6539cb88"    #QA_Salary-VPC-ID
QA_Salary_inbound_ports                       = [
  { port                                = 22, protocol = "tcp", cidr_blocks = "10.0.1.0/24" },                     # Management VPC Cidr Block
  { port                                = 22, protocol = "tcp", security_group_ids = "sg-00a65bcd92abcee70" },     #  QA-Salary-lb-sg ID
  { port                                = 8080, protocol = "tcp", security_group_ids = "sg-0d2e3609a8b620d52" },   # OpenVPN-SG
]
QA_Salary_outbound_ports                      = [
  { port                                = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" }
]
QA_Salary_Sg_tags                             = {
  Name                                  = "QA-Salary-sg"
  Enviroment                            = "QA-Salary"
  Owner                                 = "Salary"
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

QA_Salary_private_key_algorithm               = "RSA"
QA_Salary_private_key_rsa_bits                = 4096
QA_Salary_template_name                       = "QA-Salary-template"
QA_Salary_template_description                = "Template for QA-Salary"
QA_Salary_AMI_ID                              = "ami-0b8b44ec9a8f90422"
QA_Salary_instance_type                       = "t2.micro"
QA_Salary_instance_keypair                    = "QA_Salary_Key"
QA_Salary_subnet_ID                           = "subnet-03e34296260c1c84d"
QA_Salary_user_data_script_path               = "./script.sh"

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

QA_Salary_target_group_name                   = "QA-Salary-TG"
QA_Salary_target_group_port                   = 8080
QA_Salary_target_group_protocol               = "HTTP"
QA_Salary_TG_vpc_id                           = "vpc-00631f1bf6539cb88"   #QA_Salary-VPC-ID
QA_Salary_health_check_path                   = "/health"
QA_Salary_health_check_port                   = "traffic-port"
QA_Salary_health_check_interval               = 30
QA_Salary_health_check_timeout                = 5
QA_Salary_health_check_healthy_threshold      = 2
QA_Salary_health_check_unhealthy_threshold    = 2

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

QA_Salary_listener_arn                          = "arn:aws:elasticloadbalancing:us-east-2:975050171850:listener/app/QA-Salary-App/ac92eec3b47f02a1/736f0aca6a4d11a9"
QA_Salary_path_pattern                          = "/api/v1/salary/*"
QA_Salary_action_type                           = "forward"
QA_Salary_priority                              = 100

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

QA_Salary_autoscaling_group_name              = "QA-Salary-ASG"
QA_Salary_ASG_vserion                         = "$Latest"
QA_Salary_min_size                            = 1
QA_Salary_max_size                            = 2
QA_Salary_desired_capacity                    = 1
QA_Salary_subnet_ids                          = ["subnet-03e34296260c1c84d"]   #QA-Salary Pvt ID
QA_Salary_tag_key                             = "Name"
QA_Salary_tag_value                           = "QA-Salary-ASG"
QA_Salary_propagate_at_launch                 = true

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

QA_Salary_scaling_policy_name                 = "target-tracking-policy"
QA_Salary_policy_type                         = "TargetTrackingScaling"
QA_Salary_predefined_metric_type              = "ASGAverageCPUUtilization"
QA_Salary_target_value                        = 50.0

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#




