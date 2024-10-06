#!/bin/bash

sed -i 's/65\.2\.142\.186/10.0.0.7/g' /home/ubuntu/OT-Salary/migration.json # Change Scylla IP

# In Main 
sed -i 's/65\.2\.142\.186/10.0.0.7/g' /home/ubuntu/OT-Salary/src/main/resources/application.yml # Change Scylla IP
sed -i 's/65\.2\.142\.187/10.0.0.109/g' /home/ubuntu/OT-Salary/src/main/resources/application.yml  # Change Redis IP

# In Test  
sed -i 's/65\.2\.142\.186/10.0.0.7/g' /home/ubuntu/OT-Salary/src/test/resources/application.yml # Change Scylla IP
sed -i 's/65\.2\.142\.187/10.0.0.109/g' /home/ubuntu/OT-Salary/src/test/resources/application.yml  # Change Redis IP

cd /home/ubuntu/OT-Salary
make run-migrations 
sudo systemctl restart salary.service 
java -jar Salary-API/target/salary-0.1.0-RELEASE.jar  #  if you service file for salary then remove this line
