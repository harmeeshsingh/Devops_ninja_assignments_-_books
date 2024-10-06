# Security group

output "Security_Group_ID" {
  value = [module.QA_Attendance.Security_Group_ID]
}

# Private Key
output "key_pair_name" {
  value = [module.QA_Attendance.key_pair_name]
}

# Template

output "launch_template_id" {
  value = [module.QA_Attendance.launch_template_id]
}

#Target group id

output "Target_group_id" {
  value = [module.QA_Attendance.Target_group_id]
}

# ASG
output "Autoscaling_group_id" {
  value = [module.QA_Attendance.Autoscaling_group_id]
}

# ASG Policies

output "Autoscaling_policy_name" {
  value = [module.QA_Attendance.Autoscaling_policy_name]
}

