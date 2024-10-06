#---------------------------------Security Group ----------------------------------#

variable "QA_Salary_security_name" {
  description     = "Name tag for the security group"
  type            = string
  default         = "QA-Salary-sg"
}
variable "QA_Salary_security_description" {
  description     = "Description for the security group"
  type            = string
  default         = "Security group for QA-Salary-Salary-API"
}
variable "QA_Salary_SG_vpc_id" {
  description     = "ID of the VPC for instances"
  type            = string
  default         = "vpc-00631f1bf6539cb88"   # QA_Salary-VPC ID
}
variable "QA_Salary_inbound_ports" {
  description     = "List of inbound ports and protocols and cidr block"
  type            = list(map(any))
  default         = [
    { port = 22, protocol = "tcp",cidr_blocks = "10.0.1.0/24" }, # Management VPC Cidr Block
    { port = 22, protocol = "tcp", security_group_ids = "sg-00a65bcd92abcee70" },    # OpenVPN-SG
    { port = 8080, protocol = "tcp", security_group_ids = "sg-0d2e3609a8b620d52" }, #  QA-Salary-lb-sg ID 
  ]
}
variable "QA_Salary_outbound_ports" {
  description     = "List of outbound ports and protocols and Cidr block "
  type            = list(map(any))
  default         = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "QA_Salary_Sg_tags" {
  description     = "Tags for Security Group"
  type            = map(string)
  default         = {
    Name          = "QA-Salary-sg"
    Enviroment    = "QA-Salary"
    Owner         = "Shikha"
  }
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Key Generate

variable "QA_Salary_private_key_algorithm" {
  description     = "private_key_algorithm"
  type            = string
  default         = "RSA"
}
variable "QA_Salary_private_key_rsa_bits" {
  description     = "private_key_rsa_bits"
  type            = number
  default         = 4096
}

variable "QA_Salary_template_name" {
  description     = "Launch Template Name"
  type            = string
  default         = "QA-Salary-template"  
}
variable "QA_Salary_template_description" {
  description     = "Launch Template Description"
  type            = string
  default         = "Template for QA-Salary"  
}
variable "QA_Salary_AMI_ID" {
  description     = "Instance AMI ID"
  type            = string
  default         = "ami-0b8b44ec9a8f90422" # QA-Salary Setup AMI ID
}
variable "QA_Salary_instance_type" {
  description     = "Launch Template Instance Type"
  type            = string
  default         = "t2.micro"  
}
variable "QA_Salary_instance_keypair" {
  description     = "Launch Template Instance Type keypair name"
  type            = string
  default         = "QA_Salary_Key"  
}
variable "QA_Salary_subnet_ID" {
  description     = "Launch Template Subnet ID"
  type            = string
  default         = "subnet-03e34296260c1c84d"  
}
variable "QA_Salary_user_data_script_path" {
  description = "Path to the user data script file"
  type        = string
  default     = "./script.sh"  # Path QA-Salary User data Script
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

variable "QA_Salary_target_group_name" {
  description     = "Name of the target group"
  type            = string
  default         = "QA-Salary-TG"
}
variable "QA_Salary_target_group_port" {
  description     = "Port for the target group"
  type            = number 
  default         = 8080
}
variable "QA_Salary_target_group_protocol" {
  description     = "Protocol for the target group"
  type            = string
  default         = "HTTP"
}
variable "QA_Salary_TG_vpc_id" {
  description     = "ID of the VPC"
  type            = string
  default         = "vpc-00631f1bf6539cb88"    #  QA_Salary-VPC ID 
}
variable "QA_Salary_health_check_path" {
  description     = "The destination for the health check request"
  type            = string
  default         = "/health"
}
variable "QA_Salary_health_check_port" {
  description     = "The port to use to connect with the target for health checking"
  type            = string
  default         = "traffic-port"
}
variable "QA_Salary_health_check_interval" {
  description     = "The approximate amount of time, in seconds, between health checks of an individual target"
  type            = number
  default         = 30
}
variable "QA_Salary_health_check_timeout" {
  description     = "The amount of time, in seconds, during which no response means a failed health check"
  type            = number
  default         = 5
}
variable "QA_Salary_health_check_healthy_threshold" {
  description     = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type            = number
  default         = 2
}
variable "QA_Salary_health_check_unhealthy_threshold" {
  description     = "The number of consecutive health check failures required before considering a target unhealthy"
  type            = number
  default         = 2
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

variable "QA_Salary_listener_arn" {
  description       = "ARN of the existing listener where the rule will be added"
  type              = string
  default           = "arn:aws:elasticloadbalancing:us-east-2:975050171850:listener/app/QA-Salary-App/ac92eec3b47f02a1/736f0aca6a4d11a9"
}
variable "QA_Salary_path_pattern" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "/api/v1/salary/*"   # Give your Path 
}
variable "QA_Salary_action_type" {
  description       = "Path pattern for the listener rule"
  type              = string
  default           = "forward"
}
variable "QA_Salary_priority" {
  description       = "priority"
  type              = number
  default           = 100 
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

variable "QA_Salary_autoscaling_group_name" {
  description     = "The name of the Auto Scaling Group"
  type            = string
  default         = "QA_Salary_ASG"
}

variable "QA_Salary_ASG_vserion" {
  description     = "Give the Version"
  type            = string
  default         = "$Latest"
}
variable "QA_Salary_min_size" {
  description     = "The minimum number of instances in the ASG"
  type            = number
  default         = 1
}

variable "QA_Salary_max_size" {
  description     = "The maximum number of instances in the ASG"
  type            = number
  default         = 2
}

variable "QA_Salary_desired_capacity" {
  description     = "The desired number of instances in the ASG"
  type            = number
  default         = 1
}

variable "QA_Salary_subnet_ids" {
  description     = "The list of subnet IDs where the instances will be launched"
  type            = list(string)
  default         = [ "subnet-03e34296260c1c84d" ]    
} #Salary-Pvt-Subnet ID

variable "QA_Salary_tag_key" {
  description     = "The key for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Name"
}

variable "QA_Salary_tag_value" {
  description     = "The value for the tag to be applied to the ASG and instances"
  type            = string
  default         = "QA_Salary_ASG"
}

variable "QA_Salary_propagate_at_launch" {
  description     = "Whether the tag should be propagated to instances launched by the ASG"
  type            = bool
  default         = true
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

variable "QA_Salary_scaling_policy_name" {
  description     = "The name of the scaling policy"
  type            = string
  default         = "target-tracking-policy"
}
variable "QA_Salary_policy_type" {
  description     = "The type of adjustment to make"
  type            = string
  default         = "TargetTrackingScaling"
}
variable "QA_Salary_predefined_metric_type" {
  description     = "The predefined metric type for tracking"
  type            = string
  default         = "ASGAverageCPUUtilization"
}
variable "QA_Salary_target_value" {
  description     = "The target value for the predefined metric"
  type            = number
  default         = 50.0
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
