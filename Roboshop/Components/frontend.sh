#!/bin/bash


source Components/common.sh
rm -f /tmp/roboshop.log

HEAD "Installing Nginx"
yum install nginx -y #&>>/tmp/roboshop.log
STAT $?