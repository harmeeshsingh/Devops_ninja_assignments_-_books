include "root" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Auto_Sacling_Module?ref=main"  

}
inputs = {
        security_name = "qa-attendance-sg"
        Security_description = "Security group for AttendanceAPI ASG in dev environment"
        SG_vpc_id = "vpc-021ba65dc7d757ba2"
        inbound_ports = [
             { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, 
             { port = 22, protocol = "tcp", security_group_ids = "sg-069e5c14b45bd4969" },   
             { port = 8080, protocol = "tcp", security_group_ids = "sg-069e5c14b45bd4969" },  
        ]
        outbound_ports = [
            { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
        ]
        Sg_tags = {
            Name = "qa-attendance-sg"
             Enviroment    = "Dev"
            Owner         = "Shreya"                       
        }
        template_name = "qa-attendance-launch-template"
        AMI_ID = "ami-003598db5bd1895ae"
        instance_type = "t2.micro"
        instance_keypair = "attendanceKey"
        subnet_ID = "subnet-0c430d83881cbc929"
        target_group_name = "qa-attendance-target-group"
        TG_vpc_id = "vpc-021ba65dc7d757ba2"
        listener_arn = "arn:aws:elasticloadbalancing:us-east-1:630493305452:listener/app/qa-alb/714928933b0b434e/85173b5bfe61d274"
        priority = "110"
        autoscaling_group_name = "qa-attendance-asg"
        subnet_ids = ["subnet-0c430d83881cbc929"]
        tag_key = "Name"
        tag_value = "qa-attendance-asg"

}