aws_region = "us-east-1"

#----------************************** Frontend *************************------------#

#---------------------------------Security Group ----------------------------------#

Frontend_security_name                       = "Prod-Frontend-sg"
Frontend_security_description                = "Security group for Prod-Frontend-API"
Frontend_SG_vpc_id                           = "vpc-0de33c94f3ab39e13"    #Prod-VPC-ID
Frontend_inbound_ports                       = [
  { port                                = 22, protocol = "tcp", cidr_blocks = "20.0.0.0/28" },                     # Management VPC Cidr Block
  { port                                = 22, protocol = "tcp", security_group_ids = "sg-0275fdd4271ad6765" },     #OpenVPN
  { port                                = 3000, protocol = "tcp", security_group_ids = "sg-04195f62673cb7b8f" },   #Lb-sg
]
Frontend_outbound_ports                      = [
  { port                                = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" }
]
Frontend_Sg_tags                             = {
  Name                                  = "Prod-Frontend-sg"
  Enviroment                            = "Prod"
  Owner                                 = "Vishal"
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

Frontend_private_key_algorithm               = "RSA"
Frontend_private_key_rsa_bits                = 4096
Frontend_template_name                       = "Prod-Frontend-template"
Frontend_template_description                = "Template for Prod-Frontend"
Frontend_AMI_ID                              = "ami-0e75c0edf4f3c0e5b"
Frontend_instance_type                       = "t2.micro"
Frontend_instance_keypair                    = "Frontend_Key"
Frontend_subnet_ID                           = "subnet-0466147b806490677"
Frontend_user_data_script_path               = "./Script/frontend_script.sh"

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

Frontend_target_group_name                   = "Prod-Frontend-TG"
Frontend_target_group_port                   = 3000
Frontend_target_group_protocol               = "HTTP"
Frontend_TG_vpc_id                           = "vpc-0de33c94f3ab39e13"   #Prod-VPC-ID
Frontend_health_check_path                   = "/health"
Frontend_health_check_port                   = "traffic-port"
Frontend_health_check_interval               = 30
Frontend_health_check_timeout                = 5
Frontend_health_check_healthy_threshold      = 2
Frontend_health_check_unhealthy_threshold    = 2

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

Frontend_listener_arn                          = "arn:aws:elasticloadbalancing:us-east-1:133673781875:listener/app/Prod-ALB/4572571d90c0855a/eaa3745cd0e4e947"
Frontend_path_pattern                          = "*"
Frontend_action_type                           = "forward"
Frontend_priority                              = 100

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

Frontend_autoscaling_group_name              = "Prod-Frontend_ASG"
Frontend_ASG_vserion                         = "$Latest"
Frontend_min_size                            = 2
Frontend_max_size                            = 3
Frontend_desired_capacity                    = 2
Frontend_subnet_ids                          = ["subnet-0466147b806490677", "subnet-0fb3e71891cf9b277" ]   #Prod-Frontend Pvt ID
Frontend_tag_key                             = "Name"
Frontend_tag_value                           = "Prod-Frontend"
Frontend_propagate_at_launch                 = true

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

Frontend_scaling_policy_name                 = "target-tracking-policy"
Frontend_policy_type                         = "TargetTrackingScaling"
Frontend_predefined_metric_type              = "ASGAverageCPUUtilization"
Frontend_target_value                        = 50.0

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#

#----------************************** Attendance *************************------------#

#---------------------------------Security Group ----------------------------------#

Attendance_security_name                       = "Prod-Attendance-sg"
Attendance_security_description                = "Security group for Prod-Attendance-API"
Attendance_SG_vpc_id                           = "vpc-0de33c94f3ab39e13"    #Prod-VPC-ID
Attendance_inbound_ports                       = [
  { port                                = 22, protocol = "tcp", cidr_blocks = "20.0.0.0/28" },                     # Management VPC Cidr Block
  { port                                = 22, protocol = "tcp", security_group_ids = "sg-0275fdd4271ad6765" },     #OpenVPN
  { port                                = 8080, protocol = "tcp", security_group_ids = "sg-04195f62673cb7b8f" },   #Lb-sg
]
Attendance_outbound_ports                      = [
  { port                                = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" }
]
Attendance_Sg_tags                             = {
  Name                                  = "Prod-Attendance-sg"
  Enviroment                            = "Prod"
  Owner                                 = "Vishal"
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

Attendance_private_key_algorithm               = "RSA"
Attendance_private_key_rsa_bits                = 4096
Attendance_template_name                       = "Prod-Attendance-template"
Attendance_template_description                = "Template for Prod-Attendance"
Attendance_AMI_ID                              = "ami-0e75c0edf4f3c0e5b"
Attendance_instance_type                       = "t2.micro"
Attendance_instance_keypair                    = "Attendance_Key"
Attendance_subnet_ID                           = "subnet-0672110e3fb49f139"
Attendance_user_data_script_path               = "./Script/attendance_script.sh"

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

Attendance_target_group_name                   = "Prod-Attendance-TG"
Attendance_target_group_port                   = 8080
Attendance_target_group_protocol               = "HTTP"
Attendance_TG_vpc_id                           = "vpc-0de33c94f3ab39e13"   #Prod-VPC-ID
Attendance_health_check_path                   = "/health"
Attendance_health_check_port                   = "traffic-port"
Attendance_health_check_interval               = 30
Attendance_health_check_timeout                = 5
Attendance_health_check_healthy_threshold      = 2
Attendance_health_check_unhealthy_threshold    = 2

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

Attendance_listener_arn                          = "arn:aws:elasticloadbalancing:us-east-1:133673781875:listener/app/Prod-ALB/4572571d90c0855a/eaa3745cd0e4e947"
Attendance_path_pattern                          = "/api/v1/attendance/*"
Attendance_action_type                           = "forward"
Attendance_priority                              = 101

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

Attendance_autoscaling_group_name              = "Prod-Attendance_ASG"
Attendance_ASG_vserion                         = "$Latest"
Attendance_min_size                            = 2
Attendance_max_size                            = 3
Attendance_desired_capacity                    = 2
Attendance_subnet_ids                          = ["subnet-0672110e3fb49f139", "subnet-0b87e7309b10d965d" ]   #Prod-Attendance Pvt ID
Attendance_tag_key                             = "Name"
Attendance_tag_value                           = "Prod-Attendance"
Attendance_propagate_at_launch                 = true

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

Attendance_scaling_policy_name                 = "target-tracking-policy"
Attendance_policy_type                         = "TargetTrackingScaling"
Attendance_predefined_metric_type              = "ASGAverageCPUUtilization"
Attendance_target_value                        = 50.0

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#


#----------************************** Employee *************************------------#

#---------------------------------Security Group ----------------------------------#

Employee_security_name                       = "Prod-Employee-sg"
Employee_security_description                = "Security group for Prod-Employee-API"
Employee_SG_vpc_id                           = "vpc-0de33c94f3ab39e13"    #Prod-VPC-ID
Employee_inbound_ports                       = [
  { port                                = 22, protocol = "tcp", cidr_blocks = "20.0.0.0/28" },                     # Management VPC Cidr Block
  { port                                = 22, protocol = "tcp", security_group_ids = "sg-0275fdd4271ad6765" },     #OpenVPN
  { port                                = 8080, protocol = "tcp", security_group_ids = "sg-04195f62673cb7b8f" },   #Lb-sg
]
Employee_outbound_ports                      = [
  { port                                = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" }
]
Employee_Sg_tags                             = {
  Name                                  = "Prod-Employee-sg"
  Enviroment                            = "Prod"
  Owner                                 = "Vishal"
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

Employee_private_key_algorithm               = "RSA"
Employee_private_key_rsa_bits                = 4096
Employee_template_name                       = "Prod-Employee-template"
Employee_template_description                = "Template for Prod-Employee"
Employee_AMI_ID                              = "ami-0e75c0edf4f3c0e5b"
Employee_instance_type                       = "t2.medium"
Employee_instance_keypair                    = "Employee_Key"
Employee_subnet_ID                           = "subnet-0672110e3fb49f139"
Employee_user_data_script_path               = "./Script/employee_script.sh"

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

Employee_target_group_name                   = "Prod-Employee-TG"
Employee_target_group_port                   = 8080
Employee_target_group_protocol               = "HTTP"
Employee_TG_vpc_id                           = "vpc-0de33c94f3ab39e13"   #Prod-VPC-ID
Employee_health_check_path                   = "/health"
Employee_health_check_port                   = "traffic-port"
Employee_health_check_interval               = 30
Employee_health_check_timeout                = 5
Employee_health_check_healthy_threshold      = 2
Employee_health_check_unhealthy_threshold    = 2

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

Employee_listener_arn                          = "arn:aws:elasticloadbalancing:us-east-1:133673781875:listener/app/Prod-ALB/4572571d90c0855a/eaa3745cd0e4e947"
Employee_path_pattern                          = "/api/v1/employee/*"
Employee_action_type                           = "forward"
Employee_priority                              = 102

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

Employee_autoscaling_group_name              = "Prod-Employee_ASG"
Employee_ASG_vserion                         = "$Latest"
Employee_min_size                            = 2
Employee_max_size                            = 3
Employee_desired_capacity                    = 2
Employee_subnet_ids                          = ["subnet-0672110e3fb49f139", "subnet-0b87e7309b10d965d" ]   #Prod-Employee Pvt ID
Employee_tag_key                             = "Name"
Employee_tag_value                           = "Prod-Employee"
Employee_propagate_at_launch                 = true

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

Employee_scaling_policy_name                 = "target-tracking-policy"
Employee_policy_type                         = "TargetTrackingScaling"
Employee_predefined_metric_type              = "ASGAverageCPUUtilization"
Employee_target_value                        = 50.0

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#


#----------************************** Salary *************************------------#

#---------------------------------Security Group ----------------------------------#

Salary_security_name                       = "Prod-Salary-sg"
Salary_security_description                = "Security group for Prod-Salary-API"
Salary_SG_vpc_id                           = "vpc-0de33c94f3ab39e13"    #Prod-VPC-ID
Salary_inbound_ports                       = [
  { port                                = 22, protocol = "tcp", cidr_blocks = "20.0.0.0/28" },                     # Management VPC Cidr Block
  { port                                = 22, protocol = "tcp", security_group_ids = "sg-0275fdd4271ad6765" },     #OpenVPN
  { port                                = 8080, protocol = "tcp", security_group_ids = "sg-04195f62673cb7b8f" },   #Lb-sg
]
Salary_outbound_ports                      = [
  { port                                = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" }
]
Salary_Sg_tags                             = {
  Name                                  = "Prod-Salary-sg"
  Enviroment                            = "Salary"
  Owner                                 = "Vishal"
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

Salary_private_key_algorithm               = "RSA"
Salary_private_key_rsa_bits                = 4096
Salary_template_name                       = "Prod-Salary-template"
Salary_template_description                = "Template for Prod-Salary"
Salary_AMI_ID                              = "ami-0e75c0edf4f3c0e5b"
Salary_instance_type                       = "t2.micro"
Salary_instance_keypair                    = "Salary_Key"
Salary_subnet_ID                           = "subnet-0672110e3fb49f139"
Salary_user_data_script_path               = "./Script/salary_script.sh"

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

Salary_target_group_name                   = "Prod-Salary-TG"
Salary_target_group_port                   = 8080
Salary_target_group_protocol               = "HTTP"
Salary_TG_vpc_id                           = "vpc-0de33c94f3ab39e13"   #Prod-VPC-ID
Salary_health_check_path                   = "/health"
Salary_health_check_port                   = "traffic-port"
Salary_health_check_interval               = 30
Salary_health_check_timeout                = 5
Salary_health_check_healthy_threshold      = 2
Salary_health_check_unhealthy_threshold    = 2

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

Salary_listener_arn                          = "arn:aws:elasticloadbalancing:us-east-1:133673781875:listener/app/Prod-ALB/4572571d90c0855a/eaa3745cd0e4e947"
Salary_path_pattern                          = "/api/v1/salary/*"
Salary_action_type                           = "forward"
Salary_priority                              = 103

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

Salary_autoscaling_group_name              = "Prod-Salary_ASG"
Salary_ASG_vserion                         = "$Latest"
Salary_min_size                            = 2
Salary_max_size                            = 3
Salary_desired_capacity                    = 2
Salary_subnet_ids                          = ["subnet-0672110e3fb49f139", "subnet-0b87e7309b10d965d" ]   #Prod-Salary Pvt ID
Salary_tag_key                             = "Name"
Salary_tag_value                           = "Prod-Salary"
Salary_propagate_at_launch                 = true

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

Salary_scaling_policy_name                 = "target-tracking-policy"
Salary_policy_type                         = "TargetTrackingScaling"
Salary_predefined_metric_type              = "ASGAverageCPUUtilization"
Salary_target_value                        = 50.0

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
