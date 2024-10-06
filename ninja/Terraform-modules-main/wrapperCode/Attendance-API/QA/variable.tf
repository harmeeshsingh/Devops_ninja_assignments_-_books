#---------------------------------Security Group ----------------------------------#

variable "security_name" {
  description = "Name tag for the security group"
  type        = string
  default     = "attendance-sg"
}
variable "security_description" {
  description = "Description for the security group"
  type        = string
  default     = "Security group for QA Attendance API"
}
variable "vpc_id" {
  description = "ID of the VPC for instances"
  type        = string
  default     = "vpc-0d744158f7f47f419" # QA_Salary-VPC ID
}
variable "inbound_ports" {
  description = "List of inbound ports and protocols and cidr block"
  type        = list(map(any))
  default = [
    { port = 22, protocol = "tcp", cidr_blocks = "20.0.0.0/28" },                   # Management VPC Cidr Block
    { port = 22, protocol = "tcp", security_group_ids = "sg-0add0279237c66ee0" },   # OpenVPN-SG
    { port = 8080, protocol = "tcp", security_group_ids = "sg-0add0279237c66ee0" }, #  QA-Attendance-lb-sg ID 
  ]
}
variable "outbound_ports" {
  description = "List of outbound ports and protocols and Cidr block "
  type        = list(map(any))
  default = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "Sg_tags" {
  description = "Tags for Security Group"
  type        = map(string)
  default = {
    Name       = "QA-Attendance-sg"
    Enviroment = "QA_Attendance"
    Owner      = "Vidhi"
  }
}


#--------------------------------Launch Template ----------------------------------#

# Key Generate

variable "private_key_algorithm" {
  description = "private_key_algorithm"
  type        = string
  default     = "RSA"
}
variable "private_key_rsa_bits" {
  description = "private_key_rsa_bits"
  type        = number
  default     = 4096
}

variable "template_name" {
  description = "Launch Template Name"
  type        = string
  default     = "QA-Attendance-Launch-Template"
}
variable "template_description" {
  description = "Launch Template Description"
  type        = string
  default     = "Template for QA-Attendance"
}
variable "AMI_ID" {
  description = "Instance AMI ID"
  type        = string
  default     = "ami-0b622ae4dff08c413" # QA-Attendance Setup AMI ID
}
variable "instance_type" {
  description = "Launch Template Instance Type"
  type        = string
  default     = "t2.micro"
}
variable "instance_keypair" {
  description = "Launch Template Instance Type keypair name"
  type        = string
  default     = "QA_Attendance_Key"
}
variable "subnet_ID" {
  description = "Launch Template Subnet ID"
  type        = string
  default     = "subnet-03e34296260c1c84d"
}
variable "user_data_script_path" {
  description = "Path to the user data script file"
  type        = string
  default     = "./script.sh" # Path QA-Salary User data Script
}

#--------------------------------- Target Group -----------------------------------#

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
  default     = "QA-Attendance-TG"
}
variable "target_group_port" {
  description = "Port for the target group"
  type        = number
  default     = 8080
}
variable "target_group_protocol" {
  description = "Protocol for the target group"
  type        = string
  default     = "HTTP"
}
variable "TG_vpc_id" {
  description = "ID of the VPC"
  type        = string
  default     = "vpc-00631f1bf6539cb88" #  QA_Salary-VPC ID 
}
variable "health_check_path" {
  description = "The destination for the health check request"
  type        = string
  default     = "/health"
}
variable "health_check_port" {
  description = "The port to use to connect with the target for health checking"
  type        = string
  default     = "traffic-port"
}
variable "health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target"
  type        = number
  default     = 30
}
variable "health_check_timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check"
  type        = number
  default     = 5
}
variable "health_check_healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type        = number
  default     = 2
}
variable "health_check_unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering a target unhealthy"
  type        = number
  default     = 2
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

variable "listener_arn" {
  description = "ARN of the existing listener where the rule will be added"
  type        = string
  default     = "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/QA-ALB/75bc9b1a35dbe964/761653fb399a30be"
}
variable "path_pattern" {
  description = "Path pattern for the listener rule"
  type        = string
  default     = "/api/v1/attendance/*" # Give your Path 
}
variable "action_type" {
  description = "Path pattern for the listener rule"
  type        = string
  default     = "forward"
}
variable "priority" {
  description = "priority"
  type        = number
  default     = 100
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

variable "autoscaling_group_name" {
  description = "The name of the Auto Scaling Group"
  type        = string
  default     = "QA-Attendance_ASG"
}
variable "ASG_version" {
  description = "Give the Version"
  type        = string
  default     = "$Default"
}

variable "min_size" {
  description = "The minimum number of instances in the ASG"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "The maximum number of instances in the ASG"
  type        = number
  default     = 2
}

variable "desired_capacity" {
  description = "The desired number of instances in the ASG"
  type        = number
  default     = 1
}

variable "subnet_ids" {
  description = "The list of subnet IDs where the instances will be launched"
  type        = list(string)
  default     = ["subnet-03e34296260c1c84d"] #Salary-Pvt-Subnet ID
}

variable "tag_key" {
  description = "The key for the tag to be applied to the ASG and instances"
  type        = string
  default     = "Name"
}

variable "tag_value" {
  description = "The value for the tag to be applied to the ASG and instances"
  type        = string
  default     = "QA-Attendance_ASG"
}

variable "propagate_at_launch" {
  description = "Whether the tag should be propagated to instances launched by the ASG"
  type        = bool
  default     = true
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

variable "scaling_policy_name" {
  description = "The name of the scaling policy"
  type        = string
  default     = "target-tracking-policy"
}
variable "policy_type" {
  description = "The type of adjustment to make"
  type        = string
  default     = "TargetTrackingScaling"
}
variable "predefined_metric_type" {
  description = "The predefined metric type for tracking"
  type        = string
  default     = "ASGAverageCPUUtilization"
}
variable "target_value" {
  description = "The target value for the predefined metric"
  type        = number
  default     = 50.0
}
