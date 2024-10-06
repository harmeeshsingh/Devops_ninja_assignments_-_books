#!/bin/bash

sed -i 's/10\.0\.0\.8/10.0.0.4/g' /home/ubuntu/OT-attendance/liquibase.properties  # Postgress
sed -i 's/10\.0\.0\.109/10.0.0.7/g' /home/ubuntu/OT-attendance/config.yaml   # Redis
sed -i 's/10\.0\.0\.8/10.0.0.4/g'  /home/ubuntu/OT-attendance/config.yaml   # Postgress
sed -i 's/p@ssw0rd/password/g'  /home/ubuntu/OT-attendance/config.yaml  # Password changes

cd /home/ubuntu/OT-attendance
sudo apt update
make run-migrations 
sudo systemctl restart attendance.service 
