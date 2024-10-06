#---------------------------------Security Group ----------------------------------#

Dev_Frontend_security_name                       = "Dev-Frontend-sg"
Dev_Frontend_security_description                = "Security group for Dev-Frontend-API"
Dev_Frontend_SG_vpc_id                           = "vpc-0383f4dc3af051efa"    #Dev_Frontend-VPC-ID
Dev_Frontend_inbound_ports                       = [
  { port                                = 22, protocol = "tcp", cidr_blocks = "20.0.0.0/28" },                     # Management VPC Cidr Block
  { port                                = 22, protocol = "tcp", security_group_ids = "sg-0f470a22a92136557" },     #  Dev-Frontend-lb-sg ID
  { port                                = 3000, protocol = "tcp", security_group_ids = "sg-0b426399b2b19b0ae" },   # OpenVPN-SG
]
Dev_Frontend_outbound_ports                      = [
  { port                                = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" }
]
Dev_Frontend_Sg_tags                             = {
  Name                                  = "Dev-Frontend-sg"
  Enviroment                            = "Dev_Frontend"
  Owner                                 = "Vishal"
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

Dev_Frontend_private_key_algorithm               = "RSA"
Dev_Frontend_private_key_rsa_bits                = 4096
Dev_Frontend_template_name                       = "Dev-Frontend-template"
Dev_Frontend_template_description                = "Template for Dev-Frontend"
Dev_Frontend_AMI_ID                              = "ami-0c335502f397b30c6"
Dev_Frontend_instance_type                       = "t2.micro"
Dev_Frontend_instance_keypair                    = "Dev_Frontend_Key"
Dev_Frontend_subnet_ID                           = "subnet-04c0c823118f48202"
Dev_Frontend_user_data_script_path               = "./script.sh"

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

Dev_Frontend_target_group_name                   = "Dev-Frontend-TG"
Dev_Frontend_target_group_port                   = 3000
Dev_Frontend_target_group_protocol               = "HTTP"
Dev_Frontend_TG_vpc_id                           = "vpc-0383f4dc3af051efa"   #Dev_Frontend-VPC-ID
Dev_Frontend_health_check_path                   = "/health"
Dev_Frontend_health_check_port                   = "traffic-port"
Dev_Frontend_health_check_interval               = 30
Dev_Frontend_health_check_timeout                = 5
Dev_Frontend_health_check_healthy_threshold      = 2
Dev_Frontend_health_check_unhealthy_threshold    = 2

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

Dev_Frontend_listener_arn                          = "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/Dev-ALB/75bc9b1a35dbe964/761653fb399a30be"
Dev_Frontend_path_pattern                          = "*"
Dev_Frontend_action_type                           = "forward"
Dev_Frontend_priority                              = 100

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

Dev_Frontend_autoscaling_group_name              = "Dev-Frontend_ASG"
Dev_Frontend_ASG_vserion                         = "$Latest"
Dev_Frontend_min_size                            = 1
Dev_Frontend_max_size                            = 2
Dev_Frontend_desired_capacity                    = 1
Dev_Frontend_subnet_ids                          = ["subnet-04c0c823118f48202"]   #Dev-Frontend Pvt ID
Dev_Frontend_tag_key                             = "Name"
Dev_Frontend_tag_value                           = "Dev-Frontend_ASG"
Dev_Frontend_propagate_at_launch                 = true

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

Dev_Frontend_scaling_policy_name                 = "target-tracking-policy"
Dev_Frontend_policy_type                         = "TargetTrackingScaling"
Dev_Frontend_predefined_metric_type              = "ASGAverageCPUUtilization"
Dev_Frontend_target_value                        = 50.0

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#





