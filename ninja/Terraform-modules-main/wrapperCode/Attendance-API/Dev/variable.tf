#---------------------------------Security Group ----------------------------------#

variable "Dev_Attendance_security_name" {
  description     = "Name tag for the security group"
  type            = string
  default         = "QA-Frontend-sg"
}
variable "Dev_Attendance_security_description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for QA-Frontend-Frontend-API"
}
variable "Dev_Attendance_SG_vpc_id" {
  description     = "ID of the VPC for instances"
  type            = string
  default         = "vpc-0383f4dc3af051efa"   # Dev_Attendance-VPC ID
}
variable "Dev_Attendance_inbound_ports" {
  description     = "List of inbound ports and protocols and cidr block"
  type            = list(map(any))
  default         = [
    { port = 22, protocol = "tcp",cidr_blocks = "10.0.1.0/24" }, # Management VPC Cidr Block
    { port = 22, protocol = "tcp", security_group_ids = "sg-0f470a22a92136557" },    # OpenVPN-SG
    { port = 3000, protocol = "tcp", security_group_ids = "sg-0b426399b2b19b0ae" }, #  QA-Frontend-lb-sg ID 
  ]
}
variable "Dev_Attendance_outbound_ports" {
  description     = "List of outbound ports and protocols and Cidr block "
  type            = list(map(any))
  default         = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "Dev_Attendance_Sg_tags" {
  description     = "Tags for Security Group"
  type            = map(string)
  default         = {
    Name          = "QA-Frontend-sg"
    Enviroment    = "QA-Frontend"
    Owner         = "Vishal"
  }
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Key Generate

variable "Dev_Attendance_private_key_algorithm" {
  description     = "private_key_algorithm"
  type            = string
  default         = "RSA"
}
variable "Dev_Attendance_private_key_rsa_bits" {
  description     = "private_key_rsa_bits"
  type            = number
  default         = 4096
}

variable "Dev_Attendance_template_name" {
  description     = "Launch Template Name"
  type            = string
  default         = "QA-Frontend-template"  
}
variable "Dev_Attendance_template_description" {
  description     = "Launch Template Description"
  type            = string
  default         = "Template for QA-Frontend"  
}
variable "Dev_Attendance_AMI_ID" {
  description     = "Instance AMI ID"
  type            = string
  default         = "ami-0c335502f397b30c6" # QA-Frontend Setup AMI ID
}
variable "Dev_Attendance_instance_type" {
  description     = "Launch Template Instance Type"
  type            = string
  default         = "t2.micro"  
}
variable "Dev_Attendance_instance_keypair" {
  description     = "Launch Template Instance Type keypair name"
  type            = string
  default         = "Dev_Attendance_Key"  
}
variable "Dev_Attendance_subnet_ID" {
  description     = "Launch Template Subnet ID"
  type            = string
  default         = "subnet-04c0c823118f48202"  
}
variable "Dev_Attendance_user_data_script_path" {
  description = "Path to the user data script file"
  type        = string
  default     = "./script.sh"  # Path QA-Frontend User data Script
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

variable "Dev_Attendance_target_group_name" {
  description     = "Name of the target group"
  type            = string
  default         = "QA-Frontend-TG"
}
variable "Dev_Attendance_target_group_port" {
  description     = "Port for the target group"
  type            = number 
  default         = 3000
}
variable "Dev_Attendance_target_group_protocol" {
  description     = "Protocol for the target group"
  type            = string
  default         = "HTTP"
}
variable "Dev_Attendance_TG_vpc_id" {
  description     = "ID of the VPC"
  type            = string
  default         = "vpc-0383f4dc3af051efa"    #  Dev_Attendance-VPC ID 
}
variable "Dev_Attendance_health_check_path" {
  description     = "The destination for the health check request"
  type            = string
  default         = "/health"
}
variable "Dev_Attendance_health_check_port" {
  description     = "The port to use to connect with the target for health checking"
  type            = string
  default         = "traffic-port"
}
variable "Dev_Attendance_health_check_interval" {
  description     = "The approximate amount of time, in seconds, between health checks of an individual target"
  type            = number
  default         = 30
}
variable "Dev_Attendance_health_check_timeout" {
  description     = "The amount of time, in seconds, during which no response means a failed health check"
  type            = number
  default         = 5
}
variable "Dev_Attendance_health_check_healthy_threshold" {
  description     = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type            = number
  default         = 2
}
variable "Dev_Attendance_health_check_unhealthy_threshold" {
  description     = "The number of consecutive health check failures required before considering a target unhealthy"
  type            = number
  default         = 2
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

variable "Dev_Attendance_listener_arn" {
  description       = "ARN of the existing listener where the rule will be added"
  type              = string
  default           = "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/QA-ALB/28944ea6f074d63f/4f0525f30ddcc2a5"
}
variable "Dev_Attendance_path_pattern" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "*"   # Give your Path 
}
variable "Dev_Attendance_action_type" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "forward"
}
variable "Dev_Attendance_priority" {
  description       = "priority"
  type              = number
  default           = 100 
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

variable "Dev_Attendance_autoscaling_group_name" {
  description     = "The name of the Auto Scaling Group"
  type            = string
  default         = "Dev_Attendance_ASG"
}

variable "Dev_Attendance_ASG_vserion" {
  description     = "Give the Version"
  type            = string
  default         = "$Latest"
}
variable "Dev_Attendance_min_size" {
  description     = "The minimum number of instances in the ASG"
  type            = number
  default         = 1
}

variable "Dev_Attendance_max_size" {
  description     = "The maximum number of instances in the ASG"
  type            = number
  default         = 2
}

variable "Dev_Attendance_desired_capacity" {
  description     = "The desired number of instances in the ASG"
  type            = number
  default         = 1
}

variable "Dev_Attendance_subnet_ids" {
  description     = "The list of subnet IDs where the instances will be launched"
  type            = list(string)
  default         = [ "subnet-04c0c823118f48202" ]    #Frontend-Pvt-Subnet ID
}

variable "Dev_Attendance_tag_key" {
  description     = "The key for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Name"
}

variable "Dev_Attendance_tag_value" {
  description     = "The value for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Dev_Attendance_ASG"
}

variable "Dev_Attendance_propagate_at_launch" {
  description     = "Whether the tag should be propagated to instances launched by the ASG"
  type            = bool
  default         = true
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

variable "Dev_Attendance_scaling_policy_name" {
  description     = "The name of the scaling policy"
  type            = string
  default         = "target-tracking-policy"
}
variable "Dev_Attendance_policy_type" {
  description     = "The type of adjustment to make"
  type            = string
  default         = "TargetTrackingScaling"
}
variable "Dev_Attendance_predefined_metric_type" {
  description     = "The predefined metric type for tracking"
  type            = string
  default         = "ASGAverageCPUUtilization"
}
variable "Dev_Attendance_target_value" {
  description     = "The target value for the predefined metric"
  type            = number
  default         = 50.0
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#

