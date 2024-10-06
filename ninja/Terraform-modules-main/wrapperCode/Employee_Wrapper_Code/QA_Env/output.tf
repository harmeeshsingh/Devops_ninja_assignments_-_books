#----------------------------------Security Group -----------------------------------#

output "Security_Group_ID" {
  value = [module.QA_Employee.Security_Group_ID]
}

#---------------------------------Launch Template -----------------------------------#

# Priavte Key
output "key_pair_name" {
  value       = [module.QA_Employee.key_pair_name]
}

# Template
output "launch_template_id" {
  value = [module.QA_Employee.launch_template_id]
}
#---------------------------------- Target Group ------------------------------------#

output "Target_group_id" {
  value = [module.QA_Employee.Target_group_id]
}

#---------------------------Configure Auto Scaling group ----------------------------#

output "Autoscaling_group_id" {
  value = [module.QA_Employee.Autoscaling_group_id]
}

#----------------------------- Auto Scaling Policies --------------------------------#

output "Autoscaling_policy_name" {
  value       = [module.QA_Employee.Autoscaling_policy_name]
}
