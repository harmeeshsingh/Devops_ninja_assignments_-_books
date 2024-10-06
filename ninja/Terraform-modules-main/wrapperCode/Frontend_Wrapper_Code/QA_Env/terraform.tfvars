#---------------------------------Security Group ----------------------------------#

QA_Frontend_security_name                       = "QA-Frontend-sg"
QA_Frontend_security_description                = "Security group for QA-Frontend-API"
QA_Frontend_SG_vpc_id                           = "vpc-0383f4dc3af051efa"    #QA_Frontend-VPC-ID
QA_Frontend_inbound_ports                       = [
  { port                                = 22, protocol = "tcp", cidr_blocks = "10.0.1.0/24" },                     # Management VPC Cidr Block
  { port                                = 22, protocol = "tcp", security_group_ids = "sg-0f470a22a92136557" },     #  QA-Frontend-lb-sg ID
  { port                                = 3000, protocol = "tcp", security_group_ids = "sg-0b426399b2b19b0ae" },   # OpenVPN-SG
]
QA_Frontend_outbound_ports                      = [
  { port                                = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" }
]
QA_Frontend_Sg_tags                             = {
  Name                                  = "QA-Frontend-sg"
  Enviroment                            = "QA-Frontend"
  Owner                                 = "Vishal"
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

QA_Frontend_private_key_algorithm               = "RSA"
QA_Frontend_private_key_rsa_bits                = 4096
QA_Frontend_template_name                       = "QA-Frontend-template"
QA_Frontend_template_description                = "Template for QA-Frontend"
QA_Frontend_AMI_ID                              = "ami-0c335502f397b30c6"
QA_Frontend_instance_type                       = "t2.micro"
QA_Frontend_instance_keypair                    = "QA_Frontend_Key"
QA_Frontend_subnet_ID                           = "subnet-04c0c823118f48202"
QA_Frontend_user_data_script_path               = "./script.sh"

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

QA_Frontend_target_group_name                   = "QA-Frontend-TG"
QA_Frontend_target_group_port                   = 3000
QA_Frontend_target_group_protocol               = "HTTP"
QA_Frontend_TG_vpc_id                           = "vpc-0383f4dc3af051efa"   #QA_Frontend-VPC-ID
QA_Frontend_health_check_path                   = "/health"
QA_Frontend_health_check_port                   = "traffic-port"
QA_Frontend_health_check_interval               = 30
QA_Frontend_health_check_timeout                = 5
QA_Frontend_health_check_healthy_threshold      = 2
QA_Frontend_health_check_unhealthy_threshold    = 2

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

QA_Frontend_listener_arn                          = "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/QA-ALB/28944ea6f074d63f/4f0525f30ddcc2a5"
QA_Frontend_path_pattern                          = "*"
QA_Frontend_action_type                           = "forward"
QA_Frontend_priority                              = 100

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

QA_Frontend_autoscaling_group_name              = "QA-Frontend-ASG"
QA_Frontend_ASG_vserion                         = "$Latest"
QA_Frontend_min_size                            = 1
QA_Frontend_max_size                            = 2
QA_Frontend_desired_capacity                    = 1
QA_Frontend_subnet_ids                          = ["subnet-04c0c823118f48202"]   #QA-Frontend Pvt ID
QA_Frontend_tag_key                             = "Name"
QA_Frontend_tag_value                           = "QA-Frontend-ASG"
QA_Frontend_propagate_at_launch                 = true

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

QA_Frontend_scaling_policy_name                 = "target-tracking-policy"
QA_Frontend_policy_type                         = "TargetTrackingScaling"
QA_Frontend_predefined_metric_type              = "ASGAverageCPUUtilization"
QA_Frontend_target_value                        = 50.0

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#





