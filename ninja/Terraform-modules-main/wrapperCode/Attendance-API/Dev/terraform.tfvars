#---------------------------------Security Group ----------------------------------#

Dev_Attendance_security_name                       = "Dev_Attendance-sg"
Dev_Attendance_security_description                = "Security group for Dev_Attendance-API"
Dev_Attendance_SG_vpc_id                           = "vpc-007fd0dab685edb84"    #Dev-VPC-ID
Dev_Attendance_inbound_ports                       = [
  { port                                = 22, protocol = "tcp", cidr_blocks = "20.0.0.0/28" },                     # Management VPC Cidr Block
  { port                                = 22, protocol = "tcp", security_group_ids = "sg-039bbfdb5098c77e5" },     #OpenVPN
  { port                                = 8080, protocol = "tcp", security_group_ids = "sg-0daf8fbea6901da24" },   #Lb-sg
]
Dev_Attendance_outbound_ports                      = [
  { port                                = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" }
]
Dev_Attendance_Sg_tags                             = {
  Name                                  = "Dev_Attendance-sg"
  Enviroment                            = "Dev_Attendance"
  Owner                                 = "Vishal"
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

Dev_Attendance_private_key_algorithm               = "RSA"
Dev_Attendance_private_key_rsa_bits                = 4096
Dev_Attendance_template_name                       = "Dev_Attendance-template"
Dev_Attendance_template_description                = "Template for Dev_Attendance"
Dev_Attendance_AMI_ID                              = "ami-002cdb3a8b2682b91"
Dev_Attendance_instance_type                       = "t2.medium"
Dev_Attendance_instance_keypair                    = "Dev_Attendance_Key"
Dev_Attendance_subnet_ID                           = "subnet-09fcc50eed3fadec9"
Dev_Attendance_user_data_script_path               = "./script.sh"

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

Dev_Attendance_target_group_name                   = "Dev-Attendance-TG"
Dev_Attendance_target_group_port                   = 8080
Dev_Attendance_target_group_protocol               = "HTTP"
Dev_Attendance_TG_vpc_id                           = "vpc-007fd0dab685edb84"   #Dev-VPC-ID
Dev_Attendance_health_check_path                   = "/health"
Dev_Attendance_health_check_port                   = "traffic-port"
Dev_Attendance_health_check_interval               = 30
Dev_Attendance_health_check_timeout                = 5
Dev_Attendance_health_check_healthy_threshold      = 2
Dev_Attendance_health_check_unhealthy_threshold    = 2

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

Dev_Attendance_listener_arn                          = "arn:aws:elasticloadbalancing:us-east-1:630493305452:listener/app/dev-alb/fcb19c22029dc5f1/0abbb0321524949c"
Dev_Attendance_path_pattern                          = "/api/v1/attendance/*"
Dev_Attendance_action_type                           = "forward"
Dev_Attendance_priority                              = 108

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

Dev_Attendance_autoscaling_group_name              = "Dev_Attendance_ASG"
Dev_Attendance_ASG_vserion                         = "2"
#Dev_Attendance_ASG_vserion                         ="$Latest"
Dev_Attendance_min_size                            = 1
Dev_Attendance_max_size                            = 2
Dev_Attendance_desired_capacity                    = 1
Dev_Attendance_subnet_ids                          = ["subnet-0bfc1d2a2cc04f2aa" ]   #Dev_Attendance Pvt ID
Dev_Attendance_tag_key                             = "Name"
Dev_Attendance_tag_value                           = "Dev_Attendance"
Dev_Attendance_propagate_at_launch                 = true

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

Dev_Attendance_scaling_policy_name                 = "target-tracking-policy"
Dev_Attendance_policy_type                         = "TargetTrackingScaling"
Dev_Attendance_predefined_metric_type              = "ASGAverageCPUUtilization"
Dev_Attendance_target_value                        = 50.0

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
