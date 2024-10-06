#---------------------------------Security Group ----------------------------------#

variable "QA_Frontend_security_name" {
  description     = "Name tag for the security group"
  type            = string
  default         = "QA-Frontend-sg"
}
variable "QA_Frontend_security_description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for QA-Frontend-Frontend-API"
}
variable "QA_Frontend_SG_vpc_id" {
  description     = "ID of the VPC for instances"
  type            = string
  default         = "vpc-0383f4dc3af051efa"   # QA_Frontend-VPC ID
}
variable "QA_Frontend_inbound_ports" {
  description     = "List of inbound ports and protocols and cidr block"
  type            = list(map(any))
  default         = [
    { port = 22, protocol = "tcp",cidr_blocks = "10.0.1.0/24" }, # Management VPC Cidr Block
    { port = 22, protocol = "tcp", security_group_ids = "sg-0f470a22a92136557" },    # OpenVPN-SG
    { port = 3000, protocol = "tcp", security_group_ids = "sg-0b426399b2b19b0ae" }, #  QA-Frontend-lb-sg ID 
  ]
}
variable "QA_Frontend_outbound_ports" {
  description     = "List of outbound ports and protocols and Cidr block "
  type            = list(map(any))
  default         = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "QA_Frontend_Sg_tags" {
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

variable "QA_Frontend_private_key_algorithm" {
  description     = "private_key_algorithm"
  type            = string
  default         = "RSA"
}
variable "QA_Frontend_private_key_rsa_bits" {
  description     = "private_key_rsa_bits"
  type            = number
  default         = 4096
}

variable "QA_Frontend_template_name" {
  description     = "Launch Template Name"
  type            = string
  default         = "QA-Frontend-template"  
}
variable "QA_Frontend_template_description" {
  description     = "Launch Template Description"
  type            = string
  default         = "Template for QA-Frontend"  
}
variable "QA_Frontend_AMI_ID" {
  description     = "Instance AMI ID"
  type            = string
  default         = "ami-0c335502f397b30c6" # QA-Frontend Setup AMI ID
}
variable "QA_Frontend_instance_type" {
  description     = "Launch Template Instance Type"
  type            = string
  default         = "t2.micro"  
}
variable "QA_Frontend_instance_keypair" {
  description     = "Launch Template Instance Type keypair name"
  type            = string
  default         = "QA_Frontend_Key"  
}
variable "QA_Frontend_subnet_ID" {
  description     = "Launch Template Subnet ID"
  type            = string
  default         = "subnet-04c0c823118f48202"  
}
variable "QA_Frontend_user_data_script_path" {
  description = "Path to the user data script file"
  type        = string
  default     = "./script.sh"  # Path QA-Frontend User data Script
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

variable "QA_Frontend_target_group_name" {
  description     = "Name of the target group"
  type            = string
  default         = "QA-Frontend-TG"
}
variable "QA_Frontend_target_group_port" {
  description     = "Port for the target group"
  type            = number 
  default         = 3000
}
variable "QA_Frontend_target_group_protocol" {
  description     = "Protocol for the target group"
  type            = string
  default         = "HTTP"
}
variable "QA_Frontend_TG_vpc_id" {
  description     = "ID of the VPC"
  type            = string
  default         = "vpc-0383f4dc3af051efa"    #  QA_Frontend-VPC ID 
}
variable "QA_Frontend_health_check_path" {
  description     = "The destination for the health check request"
  type            = string
  default         = "/health"
}
variable "QA_Frontend_health_check_port" {
  description     = "The port to use to connect with the target for health checking"
  type            = string
  default         = "traffic-port"
}
variable "QA_Frontend_health_check_interval" {
  description     = "The approximate amount of time, in seconds, between health checks of an individual target"
  type            = number
  default         = 30
}
variable "QA_Frontend_health_check_timeout" {
  description     = "The amount of time, in seconds, during which no response means a failed health check"
  type            = number
  default         = 5
}
variable "QA_Frontend_health_check_healthy_threshold" {
  description     = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type            = number
  default         = 2
}
variable "QA_Frontend_health_check_unhealthy_threshold" {
  description     = "The number of consecutive health check failures required before considering a target unhealthy"
  type            = number
  default         = 2
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

variable "QA_Frontend_listener_arn" {
  description       = "ARN of the existing listener where the rule will be added"
  type              = string
  default           = "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/QA-ALB/28944ea6f074d63f/4f0525f30ddcc2a5"
}
variable "QA_Frontend_path_pattern" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "*"   # Give your Path 
}
variable "QA_Frontend_action_type" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "forward"
}
variable "QA_Frontend_priority" {
  description       = "priority"
  type              = number
  default           = 100 
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

variable "QA_Frontend_autoscaling_group_name" {
  description     = "The name of the Auto Scaling Group"
  type            = string
  default         = "QA_Frontend_ASG"
}

variable "QA_Frontend_ASG_vserion" {
  description     = "Give the Version"
  type            = string
  default         = "$Latest"
}
variable "QA_Frontend_min_size" {
  description     = "The minimum number of instances in the ASG"
  type            = number
  default         = 1
}

variable "QA_Frontend_max_size" {
  description     = "The maximum number of instances in the ASG"
  type            = number
  default         = 2
}

variable "QA_Frontend_desired_capacity" {
  description     = "The desired number of instances in the ASG"
  type            = number
  default         = 1
}

variable "QA_Frontend_subnet_ids" {
  description     = "The list of subnet IDs where the instances will be launched"
  type            = list(string)
  default         = [ "subnet-04c0c823118f48202" ]    #Frontend-Pvt-Subnet ID
}

variable "QA_Frontend_tag_key" {
  description     = "The key for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Name"
}

variable "QA_Frontend_tag_value" {
  description     = "The value for the tag to be applied to the ASG and instances"
  type            = string
  default         = "QA_Frontend_ASG"
}

variable "QA_Frontend_propagate_at_launch" {
  description     = "Whether the tag should be propagated to instances launched by the ASG"
  type            = bool
  default         = true
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

variable "QA_Frontend_scaling_policy_name" {
  description     = "The name of the scaling policy"
  type            = string
  default         = "target-tracking-policy"
}
variable "QA_Frontend_policy_type" {
  description     = "The type of adjustment to make"
  type            = string
  default         = "TargetTrackingScaling"
}
variable "QA_Frontend_predefined_metric_type" {
  description     = "The predefined metric type for tracking"
  type            = string
  default         = "ASGAverageCPUUtilization"
}
variable "QA_Frontend_target_value" {
  description     = "The target value for the predefined metric"
  type            = number
  default         = 50.0
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#

