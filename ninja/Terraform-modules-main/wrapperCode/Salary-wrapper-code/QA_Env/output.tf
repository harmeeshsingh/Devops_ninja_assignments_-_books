#---------------------------------Security Group ----------------------------------#

output "Security_Group_ID" {
  value = [module.QA_Salary.Security_Group_ID]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Priavte Key
output "key_pair_name" {
  value       = [module.QA_Salary.key_pair_name]
}

# Template
output "launch_template_id" {
  value = [module.QA_Salary.launch_template_id]
}
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

output "Target_group_id" {
  value = [module.QA_Salary.Target_group_id]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

output "Autoscaling_group_id" {
  value = [module.QA_Salary.Autoscaling_group_id]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

output "Autoscaling_policy_name" {
  value       = [module.QA_Salary.Autoscaling_policy_name]
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
