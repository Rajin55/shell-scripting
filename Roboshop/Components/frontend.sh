#!/bin/bash


source Components/common.sh
rm -f /tmp/roboshop.log

HEAD "Installing Nginx"
yum install nginx -y &>>/tmp/roboshop.log
STAT $?

HEAD "Download  from Github"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
STAT $?