include "root" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Auto_Sacling_Module?ref=main"  

}
inputs = {
        security_name = "qa-Salary-sg"
        Security_description = "Security group for SalaryAPI ASG in qa environment"
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
            Name = "qa-Salary-sg"
             Enviroment    = "QA"
            Owner         = "Shikha"                       
        }
        template_name = "qa-Salary-launch-template"
        AMI_ID = "ami-003598db5bd1895ae"
        instance_type = "t2.micro"
        instance_keypair = "SalaryKey"
        subnet_ID = "subnet-07f0a6d71640aa0cd"
        target_group_name = "qa-Salary-target-group"
        TG_vpc_id = "vpc-021ba65dc7d757ba2"
        listener_arn = "arn:aws:elasticloadbalancing:us-east-1:630493305452:listener/app/qa-alb/714928933b0b434e/85173b5bfe61d274"
        autoscaling_group_name = "qa-Salary-asg"
        subnet_ids = ["subnet-07f0a6d71640aa0cd"]
        tag_key = "Name"
        tag_value = "qa-Salary-asg"

}
