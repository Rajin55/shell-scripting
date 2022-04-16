#!/bin/bash

source Components/common.sh
rm -f /tmp/roboshop.log
#set-hostname catalogue

HEAD " Install Nodejs"
yum install nodejs make gcc-c++ -y &>>/tmp/roboshop.log
STAT $?

HEAD "Add Roboshop user"
id roboshop &>>/tmp/roboshop.log
if [ $? -eq 0 ];then
  echo User is alraedy there,so skkip yhe user &>>/tmp/roboshop.log
  STAT $?
else
   useradd roboshop &>>/tmp/roboshop.log
   STAT $?
fi