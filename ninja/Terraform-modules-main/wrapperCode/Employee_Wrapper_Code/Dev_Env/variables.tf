#----------------------------------Security Group -----------------------------------#

variable "Dev_Employee_security_name" {
  description     = "Name tag for the security group"
  type            = string
  default         = "Dev-Employee-sg"
}
variable "Dev_Employee_security_description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for Dev-Employee-API"
}
variable "Dev_Employee_SG_vpc_id" {
  description     = "ID of the VPC for instances"
  type            = string
  default         = "vpc-037273df63a16de65"   # Dev_Employee-VPC ID
}
variable "Dev_Employee_inbound_ports" {
  description     = "List of inbound ports and protocols and cidr block"
  type            = list(map(any))
  default         = [
    { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, # Management VPC Cidr Block
    { port = 22, protocol = "tcp", security_group_ids = "sg-04b7eb5f6320a1aa6" },    # OpenVPN-SG
    { port = 8080, protocol = "tcp", security_group_ids = "sg-04b7eb5f6320a1aa6" }, #  Dev-Employee-lb-sg ID 
  ]
}
variable "Dev_Employee_outbound_ports" {
  description     = "List of outbound ports and protocols and Cidr block "
  type            = list(map(any))
  default         = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "Dev_Employee_Sg_tags" {
  description     = "Tags for Security Group"
  type            = map(string)
  default         = {
    Name          = "Dev-Employee-sg"
    Enviroment    = "Dev_Employee"
    Owner         = "Shantanu"
  }
}

#---------------------------------Launch Template -----------------------------------#

# Key Generate

variable "Dev_Employee_private_key_algorithm" {
  description     = "private_key_algorithm"
  type            = string
  default         = "RSA"
}
variable "Dev_Employee_private_key_rsa_bits" {
  description     = "private_key_rsa_bits"
  type            = number
  default         = 4096
}

variable "Dev_Employee_template_name" {
  description     = "Launch Template Name"
  type            = string
  default         = "Dev-Employee-template"  
}
variable "Dev_Employee_template_description" {
  description     = "Launch Template Description"
  type            = string
  default         = "Template for Dev-Employee"  
}
variable "Dev_Employee_AMI_ID" {
  description     = "Instance AMI ID"
  type            = string
  default         = "ami-08e4b984abde34a4f" # Dev-Employee Setup AMI ID
}
variable "Dev_Employee_instance_type" {
  description     = "Launch Template Instance Type"
  type            = string
  default         = "t2.medium"  
}
variable "Dev_Employee_instance_keypair" {
  description     = "Launch Template Instance Type keypair name"
  type            = string
  default         = "Dev_Employee_Key"  
}
variable "Dev_Employee_subnet_ID" {
  description     = "Launch Template Subnet ID"
  type            = string
  default         = "subnet-0abcfc7a31b6687b4"  
}
variable "Dev_Employee_user_data_script_path" {
  description = "Path to the user data script file"
  type        = string
  default     = "./script.sh"  # Path Dev-Employee User data Script
}

#---------------------------------- Target Group ------------------------------------#

variable "Dev_Employee_target_group_name" {
  description     = "Name of the target group"
  type            = string
  default         = "Dev-Employee-TG"
}
variable "Dev_Employee_target_group_port" {
  description     = "Port for the target group"
  type            = number 
  default         = 8080
}
variable "Dev_Employee_target_group_protocol" {
  description     = "Protocol for the target group"
  type            = string
  default         = "HTTP"
}
variable "Dev_Employee_TG_vpc_id" {
  description     = "ID of the VPC"
  type            = string
  default         = "vpc-037273df63a16de65"    #  Dev_Employee-VPC ID 
}
variable "Dev_Employee_health_check_path" {
  description     = "The destination for the health check request"
  type            = string
  default         = "/health"
}
variable "Dev_Employee_health_check_port" {
  description     = "The port to use to connect with the target for health checking"
  type            = string
  default         = "traffic-port"
}
variable "Dev_Employee_health_check_interval" {
  description     = "The approximate amount of time, in seconds, between health checks of an individual target"
  type            = number
  default         = 30
}
variable "Dev_Employee_health_check_timeout" {
  description     = "The amount of time, in seconds, during which no response means a failed health check"
  type            = number
  default         = 5
}
variable "Dev_Employee_health_check_healthy_threshold" {
  description     = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type            = number
  default         = 2
}
variable "Dev_Employee_health_check_unhealthy_threshold" {
  description     = "The number of consecutive health check failures required before considering a target unhealthy"
  type            = number
  default         = 2
}

#-------------------------------- Listener rule of ALB ------------------------------#

variable "Dev_Employee_listener_arn" {
  description       = "ARN of the existing listener where the rule will be added"
  type              = string
  default           = "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/Dev-ALB/75bc9b1a35dbe964/761653fb399a30be"
}
variable "Dev_Employee_path_pattern" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "*"   # Give your Path 
}
variable "Dev_Employee_action_type" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "forward"
}
variable "Dev_Employee_priority" {
  description       = "priority"
  type              = number
  default           = 100 
}

#---------------------------Configure Auto Scaling group ----------------------------#

variable "Dev_Employee_autoscaling_group_name" {
  description     = "The name of the Auto Scaling Group"
  type            = string
  default         = "Dev-Employee_ASG"
}
variable "Dev_Employee_ASG_vserion" {
  description     = "Give the Version"
  type            = string
  default         = "$Latest"
}

variable "Dev_Employee_min_size" {
  description     = "The minimum number of instances in the ASG"
  type            = number
  default         = 1
}

variable "Dev_Employee_max_size" {
  description     = "The maximum number of instances in the ASG"
  type            = number
  default         = 2
}

variable "Dev_Employee_desired_capacity" {
  description     = "The desired number of instances in the ASG"
  type            = number
  default         = 1
}

variable "Dev_Employee_subnet_ids" {
  description     = "The list of subnet IDs where the instances will be launched"
  type            = list(string)
  default         = [ "subnet-0abcfc7a31b6687b4" ]    #Employee-Pvt-Subnet ID
}

variable "Dev_Employee_tag_key" {
  description     = "The key for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Name"
}

variable "Dev_Employee_tag_value" {
  description     = "The value for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Dev-Employee_ASG"
}

variable "Dev_Employee_propagate_at_launch" {
  description     = "Whether the tag should be propagated to instances launched by the ASG"
  type            = bool
  default         = true
}

#----------------------------- Auto Scaling Policies --------------------------------#

variable "Dev_Employee_scaling_policy_name" {
  description     = "The name of the scaling policy"
  type            = string
  default         = "target-tracking-policy"
}
variable "Dev_Employee_policy_type" {
  description     = "The type of adjustment to make"
  type            = string
  default         = "TargetTrackingScaling"
}
variable "Dev_Employee_predefined_metric_type" {
  description     = "The predefined metric type for tracking"
  type            = string
  default         = "ASGAverageCPUUtilization"
}
variable "Dev_Employee_target_value" {
  description     = "The target value for the predefined metric"
  type            = number
  default         = 50.0
}
