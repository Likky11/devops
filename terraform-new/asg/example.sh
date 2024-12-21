#!/bin/bash

# Update the package repository
yum update -y

# Install Apache HTTP Server
yum install -y httpd

# Start the Apache service
service httpd start

# Enable Apache to start on boot
chkconfig httpd on

# Optional: Add a custom HTML page
echo "<html><h1>Hello from Apache Web Server!</h1></html>" > /var/www/html/index.html
