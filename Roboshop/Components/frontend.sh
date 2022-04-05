#!/bin/bash

HEAD "Installing Nginx"
yum install nginx -y &>>/tmp/roboshop.log
STAT $?