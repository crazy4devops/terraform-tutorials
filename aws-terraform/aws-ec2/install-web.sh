#!/bin/bash
yum update -y
yum install httpd -y 
systemctl start httpd
systemctl enable httpd
echo "Demo Web Application" > /var/www/html/index.html