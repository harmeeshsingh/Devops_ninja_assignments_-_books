include "root" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Auto_Sacling_Module?ref=main"  

}
inputs = {
        security_name = "dev-Salary-sg"
        Security_description = "Security group for SalaryAPI ASG in dev environment"
        SG_vpc_id = "vpc-007fd0dab685edb84"
        inbound_ports = [
             { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, 
             { port = 22, protocol = "tcp", security_group_ids = "sg-0daf8fbea6901da24" },   
             { port = 8080, protocol = "tcp", security_group_ids = "sg-0daf8fbea6901da24" },  
        ]
        outbound_ports = [
            { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
        ]
        Sg_tags = {
            Name = "dev-Salary-sg"
             Enviroment    = "Dev"
            Owner         = "Shikha"                       
        }
        template_name = "dev-Salary-launch-template"
        AMI_ID = "ami-003598db5bd1895ae"
        instance_type = "t2.micro"
        instance_keypair = "SalaryDevKey"
        subnet_ID = "subnet-09fcc50eed3fadec9"
        target_group_name = "dev-Salary-target-group"
        TG_vpc_id = "vpc-007fd0dab685edb84"
        listener_arn = "arn:aws:elasticloadbalancing:us-east-1:630493305452:listener/app/dev-alb/fcb19c22029dc5f1/0abbb0321524949c"
        autoscaling_group_name = "dev-Salary-asg"
        subnet_ids = ["subnet-09fcc50eed3fadec9"]
        tag_key = "Name"
        tag_value = "dev-Salary-asg"

}
