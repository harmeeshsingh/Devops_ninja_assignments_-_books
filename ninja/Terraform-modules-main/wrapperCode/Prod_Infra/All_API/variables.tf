variable "aws_region" {
  type    = string
  default = "us-east-1"
}
#----------************************** Frontend *************************------------#


#---------------------------------Security Group ----------------------------------#

variable "Frontend_security_name" {
  description     = "Name tag for the security group"
  type            = string
  default         = "Dev-Frontend-sg"
}
variable "Frontend_security_description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for Dev-Frontend-API"
}
variable "Frontend_SG_vpc_id" {
  description     = "ID of the VPC for instances"
  type            = string
  default         = "vpc-0383f4dc3af051efa"   # Frontend-VPC ID
}
variable "Frontend_inbound_ports" {
  description     = "List of inbound ports and protocols and cidr block"
  type            = list(map(any))
  default         = [
    { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, # Management VPC Cidr Block
    { port = 22, protocol = "tcp", security_group_ids = "sg-0f470a22a92136557" },    # OpenVPN-SG
    { port = 3000, protocol = "tcp", security_group_ids = "sg-0b426399b2b19b0ae" }, #  Dev-Frontend-lb-sg ID 
  ]
}
variable "Frontend_outbound_ports" {
  description     = "List of outbound ports and protocols and Cidr block "
  type            = list(map(any))
  default         = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "Frontend_Sg_tags" {
  description     = "Tags for Security Group"
  type            = map(string)
  default         = {
    Name          = "Dev-Frontend-sg"
    Enviroment    = "Frontend"
    Owner         = "Vishal"
  }
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Key Generate

variable "Frontend_private_key_algorithm" {
  description     = "private_key_algorithm"
  type            = string
  default         = "RSA"
}
variable "Frontend_private_key_rsa_bits" {
  description     = "private_key_rsa_bits"
  type            = number
  default         = 4096
}

variable "Frontend_template_name" {
  description     = "Launch Template Name"
  type            = string
  default         = "Dev-Frontend-template"  
}
variable "Frontend_template_description" {
  description     = "Launch Template Description"
  type            = string
  default         = "Template for Dev-Frontend"  
}
variable "Frontend_AMI_ID" {
  description     = "Instance AMI ID"
  type            = string
  default         = "ami-0c335502f397b30c6" # Dev-Frontend Setup AMI ID
}
variable "Frontend_instance_type" {
  description     = "Launch Template Instance Type"
  type            = string
  default         = "t2.micro"  
}
variable "Frontend_instance_keypair" {
  description     = "Launch Template Instance Type keypair name"
  type            = string
  default         = "Frontend_Key"  
}
variable "Frontend_subnet_ID" {
  description     = "Launch Template Subnet ID"
  type            = string
  default         = "subnet-04c0c823118f48202"  
}
variable "Frontend_user_data_script_path" {
  description = "Path to the user data script file"
  type        = string
  default     = "./script.sh"  # Path Dev-Frontend User data Script
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

variable "Frontend_target_group_name" {
  description     = "Name of the target group"
  type            = string
  default         = "Dev-Frontend-TG"
}
variable "Frontend_target_group_port" {
  description     = "Port for the target group"
  type            = number 
  default         = 3000
}
variable "Frontend_target_group_protocol" {
  description     = "Protocol for the target group"
  type            = string
  default         = "HTTP"
}
variable "Frontend_TG_vpc_id" {
  description     = "ID of the VPC"
  type            = string
  default         = "vpc-0383f4dc3af051efa"    #  Frontend-VPC ID 
}
variable "Frontend_health_check_path" {
  description     = "The destination for the health check request"
  type            = string
  default         = "/health"
}
variable "Frontend_health_check_port" {
  description     = "The port to use to connect with the target for health checking"
  type            = string
  default         = "traffic-port"
}
variable "Frontend_health_check_interval" {
  description     = "The approximate amount of time, in seconds, between health checks of an individual target"
  type            = number
  default         = 30
}
variable "Frontend_health_check_timeout" {
  description     = "The amount of time, in seconds, during which no response means a failed health check"
  type            = number
  default         = 5
}
variable "Frontend_health_check_healthy_threshold" {
  description     = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type            = number
  default         = 2
}
variable "Frontend_health_check_unhealthy_threshold" {
  description     = "The number of consecutive health check failures required before considering a target unhealthy"
  type            = number
  default         = 2
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

variable "Frontend_listener_arn" {
  description       = "ARN of the existing listener where the rule will be added"
  type              = string
  default           = "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/Dev-ALB/75bc9b1a35dbe964/761653fb399a30be"
}
variable "Frontend_path_pattern" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "*"   # Give your Path 
}
variable "Frontend_action_type" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "forward"
}
variable "Frontend_priority" {
  description       = "priority"
  type              = number
  default           = 100 
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

variable "Frontend_autoscaling_group_name" {
  description     = "The name of the Auto Scaling Group"
  type            = string
  default         = "Dev-Frontend_ASG"
}
variable "Frontend_ASG_vserion" {
  description     = "Give the Version"
  type            = string
  default         = "$Latest"
}

variable "Frontend_min_size" {
  description     = "The minimum number of instances in the ASG"
  type            = number
  default         = 1
}

variable "Frontend_max_size" {
  description     = "The maximum number of instances in the ASG"
  type            = number
  default         = 2
}

variable "Frontend_desired_capacity" {
  description     = "The desired number of instances in the ASG"
  type            = number
  default         = 1
}

variable "Frontend_subnet_ids" {
  description     = "The list of subnet IDs where the instances will be launched"
  type            = list(string)
  default         = [ "subnet-04c0c823118f48202" ]    #Frontend-Pvt-Subnet ID
}

variable "Frontend_tag_key" {
  description     = "The key for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Name"
}

variable "Frontend_tag_value" {
  description     = "The value for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Dev-Frontend_ASG"
}

variable "Frontend_propagate_at_launch" {
  description     = "Whether the tag should be propagated to instances launched by the ASG"
  type            = bool
  default         = true
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

variable "Frontend_scaling_policy_name" {
  description     = "The name of the scaling policy"
  type            = string
  default         = "target-tracking-policy"
}
variable "Frontend_policy_type" {
  description     = "The type of adjustment to make"
  type            = string
  default         = "TargetTrackingScaling"
}
variable "Frontend_predefined_metric_type" {
  description     = "The predefined metric type for tracking"
  type            = string
  default         = "ASGAverageCPUUtilization"
}
variable "Frontend_target_value" {
  description     = "The target value for the predefined metric"
  type            = number
  default         = 50.0
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#

#----------************************** Attendance *************************------------#


#---------------------------------Security Group ----------------------------------#

variable "Attendance_security_name" {
  description     = "Name tag for the security group"
  type            = string
  default         = "Dev-Attendance-sg"
}
variable "Attendance_security_description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for Dev-Attendance-API"
}
variable "Attendance_SG_vpc_id" {
  description     = "ID of the VPC for instances"
  type            = string
  default         = "vpc-0383f4dc3af051efa"   # Attendance-VPC ID
}
variable "Attendance_inbound_ports" {
  description     = "List of inbound ports and protocols and cidr block"
  type            = list(map(any))
  default         = [
    { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, # Management VPC Cidr Block
    { port = 22, protocol = "tcp", security_group_ids = "sg-0f470a22a92136557" },    # OpenVPN-SG
    { port = 3000, protocol = "tcp", security_group_ids = "sg-0b426399b2b19b0ae" }, #  Dev-Attendance-lb-sg ID 
  ]
}
variable "Attendance_outbound_ports" {
  description     = "List of outbound ports and protocols and Cidr block "
  type            = list(map(any))
  default         = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "Attendance_Sg_tags" {
  description     = "Tags for Security Group"
  type            = map(string)
  default         = {
    Name          = "Dev-Attendance-sg"
    Enviroment    = "Attendance"
    Owner         = "Vishal"
  }
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Key Generate

variable "Attendance_private_key_algorithm" {
  description     = "private_key_algorithm"
  type            = string
  default         = "RSA"
}
variable "Attendance_private_key_rsa_bits" {
  description     = "private_key_rsa_bits"
  type            = number
  default         = 4096
}

variable "Attendance_template_name" {
  description     = "Launch Template Name"
  type            = string
  default         = "Dev-Attendance-template"  
}
variable "Attendance_template_description" {
  description     = "Launch Template Description"
  type            = string
  default         = "Template for Dev-Attendance"  
}
variable "Attendance_AMI_ID" {
  description     = "Instance AMI ID"
  type            = string
  default         = "ami-0c335502f397b30c6" # Dev-Attendance Setup AMI ID
}
variable "Attendance_instance_type" {
  description     = "Launch Template Instance Type"
  type            = string
  default         = "t2.micro"  
}
variable "Attendance_instance_keypair" {
  description     = "Launch Template Instance Type keypair name"
  type            = string
  default         = "Attendance_Key"  
}
variable "Attendance_subnet_ID" {
  description     = "Launch Template Subnet ID"
  type            = string
  default         = "subnet-04c0c823118f48202"  
}
variable "Attendance_user_data_script_path" {
  description = "Path to the user data script file"
  type        = string
  default     = "./script.sh"  # Path Dev-Attendance User data Script
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

variable "Attendance_target_group_name" {
  description     = "Name of the target group"
  type            = string
  default         = "Dev-Attendance-TG"
}
variable "Attendance_target_group_port" {
  description     = "Port for the target group"
  type            = number 
  default         = 3000
}
variable "Attendance_target_group_protocol" {
  description     = "Protocol for the target group"
  type            = string
  default         = "HTTP"
}
variable "Attendance_TG_vpc_id" {
  description     = "ID of the VPC"
  type            = string
  default         = "vpc-0383f4dc3af051efa"    #  Attendance-VPC ID 
}
variable "Attendance_health_check_path" {
  description     = "The destination for the health check request"
  type            = string
  default         = "/health"
}
variable "Attendance_health_check_port" {
  description     = "The port to use to connect with the target for health checking"
  type            = string
  default         = "traffic-port"
}
variable "Attendance_health_check_interval" {
  description     = "The approximate amount of time, in seconds, between health checks of an individual target"
  type            = number
  default         = 30
}
variable "Attendance_health_check_timeout" {
  description     = "The amount of time, in seconds, during which no response means a failed health check"
  type            = number
  default         = 5
}
variable "Attendance_health_check_healthy_threshold" {
  description     = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type            = number
  default         = 2
}
variable "Attendance_health_check_unhealthy_threshold" {
  description     = "The number of consecutive health check failures required before considering a target unhealthy"
  type            = number
  default         = 2
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

variable "Attendance_listener_arn" {
  description       = "ARN of the existing listener where the rule will be added"
  type              = string
  default           = "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/Dev-ALB/75bc9b1a35dbe964/761653fb399a30be"
}
variable "Attendance_path_pattern" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "*"   # Give your Path 
}
variable "Attendance_action_type" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "forward"
}
variable "Attendance_priority" {
  description       = "priority"
  type              = number
  default           = 100 
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

variable "Attendance_autoscaling_group_name" {
  description     = "The name of the Auto Scaling Group"
  type            = string
  default         = "Dev-Attendance_ASG"
}
variable "Attendance_ASG_vserion" {
  description     = "Give the Version"
  type            = string
  default         = "$Latest"
}

variable "Attendance_min_size" {
  description     = "The minimum number of instances in the ASG"
  type            = number
  default         = 1
}

variable "Attendance_max_size" {
  description     = "The maximum number of instances in the ASG"
  type            = number
  default         = 2
}

variable "Attendance_desired_capacity" {
  description     = "The desired number of instances in the ASG"
  type            = number
  default         = 1
}

variable "Attendance_subnet_ids" {
  description     = "The list of subnet IDs where the instances will be launched"
  type            = list(string)
  default         = [ "subnet-04c0c823118f48202" ]    #Attendance-Pvt-Subnet ID
}

variable "Attendance_tag_key" {
  description     = "The key for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Name"
}

variable "Attendance_tag_value" {
  description     = "The value for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Dev-Attendance_ASG"
}

variable "Attendance_propagate_at_launch" {
  description     = "Whether the tag should be propagated to instances launched by the ASG"
  type            = bool
  default         = true
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

variable "Attendance_scaling_policy_name" {
  description     = "The name of the scaling policy"
  type            = string
  default         = "target-tracking-policy"
}
variable "Attendance_policy_type" {
  description     = "The type of adjustment to make"
  type            = string
  default         = "TargetTrackingScaling"
}
variable "Attendance_predefined_metric_type" {
  description     = "The predefined metric type for tracking"
  type            = string
  default         = "ASGAverageCPUUtilization"
}
variable "Attendance_target_value" {
  description     = "The target value for the predefined metric"
  type            = number
  default         = 50.0
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#

#----------************************** Employee *************************------------#


#---------------------------------Security Group ----------------------------------#

variable "Employee_security_name" {
  description     = "Name tag for the security group"
  type            = string
  default         = "Dev-Employee-sg"
}
variable "Employee_security_description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for Dev-Employee-API"
}
variable "Employee_SG_vpc_id" {
  description     = "ID of the VPC for instances"
  type            = string
  default         = "vpc-0383f4dc3af051efa"   # Employee-VPC ID
}
variable "Employee_inbound_ports" {
  description     = "List of inbound ports and protocols and cidr block"
  type            = list(map(any))
  default         = [
    { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, # Management VPC Cidr Block
    { port = 22, protocol = "tcp", security_group_ids = "sg-0f470a22a92136557" },    # OpenVPN-SG
    { port = 3000, protocol = "tcp", security_group_ids = "sg-0b426399b2b19b0ae" }, #  Dev-Employee-lb-sg ID 
  ]
}
variable "Employee_outbound_ports" {
  description     = "List of outbound ports and protocols and Cidr block "
  type            = list(map(any))
  default         = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "Employee_Sg_tags" {
  description     = "Tags for Security Group"
  type            = map(string)
  default         = {
    Name          = "Dev-Employee-sg"
    Enviroment    = "Employee"
    Owner         = "Vishal"
  }
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Key Generate

variable "Employee_private_key_algorithm" {
  description     = "private_key_algorithm"
  type            = string
  default         = "RSA"
}
variable "Employee_private_key_rsa_bits" {
  description     = "private_key_rsa_bits"
  type            = number
  default         = 4096
}

variable "Employee_template_name" {
  description     = "Launch Template Name"
  type            = string
  default         = "Dev-Employee-template"  
}
variable "Employee_template_description" {
  description     = "Launch Template Description"
  type            = string
  default         = "Template for Dev-Employee"  
}
variable "Employee_AMI_ID" {
  description     = "Instance AMI ID"
  type            = string
  default         = "ami-0c335502f397b30c6" # Dev-Employee Setup AMI ID
}
variable "Employee_instance_type" {
  description     = "Launch Template Instance Type"
  type            = string
  default         = "t2.micro"  
}
variable "Employee_instance_keypair" {
  description     = "Launch Template Instance Type keypair name"
  type            = string
  default         = "Employee_Key"  
}
variable "Employee_subnet_ID" {
  description     = "Launch Template Subnet ID"
  type            = string
  default         = "subnet-04c0c823118f48202"  
}
variable "Employee_user_data_script_path" {
  description = "Path to the user data script file"
  type        = string
  default     = "./script.sh"  # Path Dev-Employee User data Script
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

variable "Employee_target_group_name" {
  description     = "Name of the target group"
  type            = string
  default         = "Dev-Employee-TG"
}
variable "Employee_target_group_port" {
  description     = "Port for the target group"
  type            = number 
  default         = 3000
}
variable "Employee_target_group_protocol" {
  description     = "Protocol for the target group"
  type            = string
  default         = "HTTP"
}
variable "Employee_TG_vpc_id" {
  description     = "ID of the VPC"
  type            = string
  default         = "vpc-0383f4dc3af051efa"    #  Employee-VPC ID 
}
variable "Employee_health_check_path" {
  description     = "The destination for the health check request"
  type            = string
  default         = "/health"
}
variable "Employee_health_check_port" {
  description     = "The port to use to connect with the target for health checking"
  type            = string
  default         = "traffic-port"
}
variable "Employee_health_check_interval" {
  description     = "The approximate amount of time, in seconds, between health checks of an individual target"
  type            = number
  default         = 30
}
variable "Employee_health_check_timeout" {
  description     = "The amount of time, in seconds, during which no response means a failed health check"
  type            = number
  default         = 5
}
variable "Employee_health_check_healthy_threshold" {
  description     = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type            = number
  default         = 2
}
variable "Employee_health_check_unhealthy_threshold" {
  description     = "The number of consecutive health check failures required before considering a target unhealthy"
  type            = number
  default         = 2
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

variable "Employee_listener_arn" {
  description       = "ARN of the existing listener where the rule will be added"
  type              = string
  default           = "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/Dev-ALB/75bc9b1a35dbe964/761653fb399a30be"
}
variable "Employee_path_pattern" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "*"   # Give your Path 
}
variable "Employee_action_type" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "forward"
}
variable "Employee_priority" {
  description       = "priority"
  type              = number
  default           = 100 
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

variable "Employee_autoscaling_group_name" {
  description     = "The name of the Auto Scaling Group"
  type            = string
  default         = "Dev-Employee_ASG"
}
variable "Employee_ASG_vserion" {
  description     = "Give the Version"
  type            = string
  default         = "$Latest"
}

variable "Employee_min_size" {
  description     = "The minimum number of instances in the ASG"
  type            = number
  default         = 1
}

variable "Employee_max_size" {
  description     = "The maximum number of instances in the ASG"
  type            = number
  default         = 2
}

variable "Employee_desired_capacity" {
  description     = "The desired number of instances in the ASG"
  type            = number
  default         = 1
}

variable "Employee_subnet_ids" {
  description     = "The list of subnet IDs where the instances will be launched"
  type            = list(string)
  default         = [ "subnet-04c0c823118f48202" ]    #Employee-Pvt-Subnet ID
}

variable "Employee_tag_key" {
  description     = "The key for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Name"
}

variable "Employee_tag_value" {
  description     = "The value for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Dev-Employee_ASG"
}

variable "Employee_propagate_at_launch" {
  description     = "Whether the tag should be propagated to instances launched by the ASG"
  type            = bool
  default         = true
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

variable "Employee_scaling_policy_name" {
  description     = "The name of the scaling policy"
  type            = string
  default         = "target-tracking-policy"
}
variable "Employee_policy_type" {
  description     = "The type of adjustment to make"
  type            = string
  default         = "TargetTrackingScaling"
}
variable "Employee_predefined_metric_type" {
  description     = "The predefined metric type for tracking"
  type            = string
  default         = "ASGAverageCPUUtilization"
}
variable "Employee_target_value" {
  description     = "The target value for the predefined metric"
  type            = number
  default         = 50.0
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#----------************************** Salary *************************------------#


#---------------------------------Security Group ----------------------------------#

variable "Salary_security_name" {
  description     = "Name tag for the security group"
  type            = string
  default         = "Dev-Salary-sg"
}
variable "Salary_security_description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for Dev-Salary-API"
}
variable "Salary_SG_vpc_id" {
  description     = "ID of the VPC for instances"
  type            = string
  default         = "vpc-0383f4dc3af051efa"   # Salary-VPC ID
}
variable "Salary_inbound_ports" {
  description     = "List of inbound ports and protocols and cidr block"
  type            = list(map(any))
  default         = [
    { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, # Management VPC Cidr Block
    { port = 22, protocol = "tcp", security_group_ids = "sg-0f470a22a92136557" },    # OpenVPN-SG
    { port = 3000, protocol = "tcp", security_group_ids = "sg-0b426399b2b19b0ae" }, #  Dev-Salary-lb-sg ID 
  ]
}
variable "Salary_outbound_ports" {
  description     = "List of outbound ports and protocols and Cidr block "
  type            = list(map(any))
  default         = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "Salary_Sg_tags" {
  description     = "Tags for Security Group"
  type            = map(string)
  default         = {
    Name          = "Dev-Salary-sg"
    Enviroment    = "Salary"
    Owner         = "Vishal"
  }
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Key Generate

variable "Salary_private_key_algorithm" {
  description     = "private_key_algorithm"
  type            = string
  default         = "RSA"
}
variable "Salary_private_key_rsa_bits" {
  description     = "private_key_rsa_bits"
  type            = number
  default         = 4096
}

variable "Salary_template_name" {
  description     = "Launch Template Name"
  type            = string
  default         = "Dev-Salary-template"  
}
variable "Salary_template_description" {
  description     = "Launch Template Description"
  type            = string
  default         = "Template for Dev-Salary"  
}
variable "Salary_AMI_ID" {
  description     = "Instance AMI ID"
  type            = string
  default         = "ami-0c335502f397b30c6" # Dev-Salary Setup AMI ID
}
variable "Salary_instance_type" {
  description     = "Launch Template Instance Type"
  type            = string
  default         = "t2.micro"  
}
variable "Salary_instance_keypair" {
  description     = "Launch Template Instance Type keypair name"
  type            = string
  default         = "Salary_Key"  
}
variable "Salary_subnet_ID" {
  description     = "Launch Template Subnet ID"
  type            = string
  default         = "subnet-04c0c823118f48202"  
}
variable "Salary_user_data_script_path" {
  description = "Path to the user data script file"
  type        = string
  default     = "./script.sh"  # Path Dev-Salary User data Script
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

variable "Salary_target_group_name" {
  description     = "Name of the target group"
  type            = string
  default         = "Dev-Salary-TG"
}
variable "Salary_target_group_port" {
  description     = "Port for the target group"
  type            = number 
  default         = 3000
}
variable "Salary_target_group_protocol" {
  description     = "Protocol for the target group"
  type            = string
  default         = "HTTP"
}
variable "Salary_TG_vpc_id" {
  description     = "ID of the VPC"
  type            = string
  default         = "vpc-0383f4dc3af051efa"    #  Salary-VPC ID 
}
variable "Salary_health_check_path" {
  description     = "The destination for the health check request"
  type            = string
  default         = "/health"
}
variable "Salary_health_check_port" {
  description     = "The port to use to connect with the target for health checking"
  type            = string
  default         = "traffic-port"
}
variable "Salary_health_check_interval" {
  description     = "The approximate amount of time, in seconds, between health checks of an individual target"
  type            = number
  default         = 30
}
variable "Salary_health_check_timeout" {
  description     = "The amount of time, in seconds, during which no response means a failed health check"
  type            = number
  default         = 5
}
variable "Salary_health_check_healthy_threshold" {
  description     = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type            = number
  default         = 2
}
variable "Salary_health_check_unhealthy_threshold" {
  description     = "The number of consecutive health check failures required before considering a target unhealthy"
  type            = number
  default         = 2
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

variable "Salary_listener_arn" {
  description       = "ARN of the existing listener where the rule will be added"
  type              = string
  default           = "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/Dev-ALB/75bc9b1a35dbe964/761653fb399a30be"
}
variable "Salary_path_pattern" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "*"   # Give your Path 
}
variable "Salary_action_type" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "forward"
}
variable "Salary_priority" {
  description       = "priority"
  type              = number
  default           = 100 
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

variable "Salary_autoscaling_group_name" {
  description     = "The name of the Auto Scaling Group"
  type            = string
  default         = "Dev-Salary_ASG"
}
variable "Salary_ASG_vserion" {
  description     = "Give the Version"
  type            = string
  default         = "$Latest"
}

variable "Salary_min_size" {
  description     = "The minimum number of instances in the ASG"
  type            = number
  default         = 1
}

variable "Salary_max_size" {
  description     = "The maximum number of instances in the ASG"
  type            = number
  default         = 2
}

variable "Salary_desired_capacity" {
  description     = "The desired number of instances in the ASG"
  type            = number
  default         = 1
}

variable "Salary_subnet_ids" {
  description     = "The list of subnet IDs where the instances will be launched"
  type            = list(string)
  default         = [ "subnet-04c0c823118f48202" ]    #Salary-Pvt-Subnet ID
}

variable "Salary_tag_key" {
  description     = "The key for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Name"
}

variable "Salary_tag_value" {
  description     = "The value for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Dev-Salary_ASG"
}

variable "Salary_propagate_at_launch" {
  description     = "Whether the tag should be propagated to instances launched by the ASG"
  type            = bool
  default         = true
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

variable "Salary_scaling_policy_name" {
  description     = "The name of the scaling policy"
  type            = string
  default         = "target-tracking-policy"
}
variable "Salary_policy_type" {
  description     = "The type of adjustment to make"
  type            = string
  default         = "TargetTrackingScaling"
}
variable "Salary_predefined_metric_type" {
  description     = "The predefined metric type for tracking"
  type            = string
  default         = "ASGAverageCPUUtilization"
}
variable "Salary_target_value" {
  description     = "The target value for the predefined metric"
  type            = number
  default         = 50.0
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#

