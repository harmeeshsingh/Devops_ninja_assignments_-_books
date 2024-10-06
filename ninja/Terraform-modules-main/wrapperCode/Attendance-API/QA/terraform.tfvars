#---------------------------------Security Group ----------------------------------#

security_name        = "QA-Attendance-sg"
security_description = "Security group for QA Attendance API"
vpc_id               = "vpc-0d744158f7f47f419" #QA_Salary-VPC-ID
inbound_ports = [
  { port = 22, protocol = "tcp", cidr_blocks = "20.0.0.0/28" },                   # Management VPC Cidr Block
  { port = 22, protocol = "tcp", security_group_ids = "sg-061f905ed2cbb0652" },   #  QA-Salary-lb-sg ID
  { port = 8080, protocol = "tcp", security_group_ids = "sg-061f905ed2cbb0652" }, # OpenVPN-SG
]
outbound_ports = [
  { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" }
]
Sg_tags = {
  Name       = "QA-Attendance-sg"
  Enviroment = "QA_Attendance"
  Owner      = "Vidhi"
}

#--------------------------------Launch Template ----------------------------------#

private_key_algorithm = "RSA"
private_key_rsa_bits  = 4096
template_name         = "QA-Attendance-Launch-Template"
template_description  = "Template for Attendance"
AMI_ID                = "ami-0b622ae4dff08c413"
instance_type         = "t2.micro"
instance_keypair      = "QA_Attendance_Key"
subnet_ID             = "subnet-0a712151efeb16f4f"
user_data_script_path = "./script.sh"

#--------------------------------- Target Group -----------------------------------#

target_group_name                = "QA-Attendance-TG"
target_group_port                = 8080
target_group_protocol            = "HTTP"
TG_vpc_id                        = "vpc-0d744158f7f47f419" #QA_Attendance-VPC-ID
health_check_path                = "/health"
health_check_port                = "traffic-port"
health_check_interval            = 30
health_check_timeout             = 5
health_check_healthy_threshold   = 2
health_check_unhealthy_threshold = 2


#------------------------------- Listener rule of ALB -----------------------------#

listener_arn = "arn:aws:elasticloadbalancing:us-east-1:905418193488:listener/app/alb-heh/127dfdd55a957475/99ac24ae778e4e38"
path_pattern = "/api/v1/attendance/*"
action_type  = "forward"
priority     = 90


#--------------------------Configure Auto Scaling group ---------------------------#

autoscaling_group_name = "QA-Attendance_ASG"
ASG_version            = "$Latest"
min_size               = 1
max_size               = 2
desired_capacity       = 1
subnet_ids             = ["subnet-0a712151efeb16f4f"] #QA-Salary Pvt ID
tag_key                = "Name"
tag_value              = "QA-Attendance_ASG"
propagate_at_launch    = false

#---------------------------- Auto Scaling Policies -------------------------------#

scaling_policy_name    = "target-tracking-policy"
policy_type            = "TargetTrackingScaling"
predefined_metric_type = "ASGAverageCPUUtilization"
target_value           = 50.0
