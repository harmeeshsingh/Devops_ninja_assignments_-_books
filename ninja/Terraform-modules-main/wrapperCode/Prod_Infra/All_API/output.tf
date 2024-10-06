#----------************************** Frontend *************************------------#
#---------------------------------Security Group ----------------------------------#

output "Frontend_Security_Group_IDs" {
  value = module.Frontend.Security_Group_IDs
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Priavte Key
output "Frontend_key_pair_name" {
  value       = module.Frontend.key_pair_name
}

# Template
output "Frontend_launch_template_id" {
  value = module.Frontend.launch_template_id
}
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

output "Frontend_Target_group_id" {
  value = module.Frontend.Target_group_id
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

output "Frontend_Autoscaling_group_id" {
  value = module.Frontend.Autoscaling_group_id
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

output "Frontend_Autoscaling_policy_name" {
  value       = module.Frontend.Autoscaling_policy_name
}

#----------************************** Attendance *************************------------#
#---------------------------------Security Group ----------------------------------#

output "Attendance_Security_Group_IDs" {
  value = module.Attendance.Security_Group_IDs
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Priavte Key
output "Attendance_key_pair_name" {
  value       = module.Attendance.key_pair_name
}

# Template
output "Attendance_launch_template_id" {
  value = module.Attendance.launch_template_id
}
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

output "Attendance_Target_group_id" {
  value = module.Attendance.Target_group_id
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

output "Attendance_Autoscaling_group_id" {
  value = module.Attendance.Autoscaling_group_id
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

output "Attendance_Autoscaling_policy_name" {
  value       = module.Attendance.Autoscaling_policy_name
}

#----------************************** Employee *************************------------#
#---------------------------------Security Group ----------------------------------#

output "Employee_Security_Group_IDs" {
  value = module.Employee.Security_Group_IDs
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Priavte Key
output "Employee_key_pair_name" {
  value       = module.Employee.key_pair_name
}

# Template
output "Employee_launch_template_id" {
  value = module.Employee.launch_template_id
}
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

output "Employee_Target_group_id" {
  value = module.Employee.Target_group_id
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

output "Employee_Autoscaling_group_id" {
  value = module.Employee.Autoscaling_group_id
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

output "Employee_Autoscaling_policy_name" {
  value       = module.Employee.Autoscaling_policy_name
}

#----------************************** Salary *************************------------#
#---------------------------------Security Group ----------------------------------#

output "Salary_Security_Group_IDs" {
  value = module.Salary.Security_Group_IDs
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

# Priavte Key
output "Salary_key_pair_name" {
  value       = module.Salary.key_pair_name
}

# Template
output "Salary_launch_template_id" {
  value = module.Salary.launch_template_id
}
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

output "Salary_Target_group_id" {
  value = module.Salary.Target_group_id
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

output "Salary_Autoscaling_group_id" {
  value = module.Salary.Autoscaling_group_id
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

output "Salary_Autoscaling_policy_name" {
  value       = module.Salary.Autoscaling_policy_name
}

