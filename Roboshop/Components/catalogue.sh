#!/bin/bash

source Components/common.sh
rm -f /tmp/roboshop.log
#set-hostname catalogue

HEAD "Install Nodejs"
yum install nodejs make gcc-c++ -y &>>/tmp/roboshop.log
STAT $?

HEAD "Add Roboshop user"
id roboshop &>>/tmp/roboshop.log
if [ $? -eq 0 ];then
  echo User is alraedy there,so skkip the user &>>/tmp/roboshop.log
  STAT $?
else
   useradd roboshop &>>/tmp/roboshop.log
   STAT $?
fi

HEAD "Download App from GitHub"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>/tmp/roboshop.log
STAT $?

HEAD "Extract the Downloaded file"
cd /home/roboshop && rm -rf catalogue && unzip /tmp/catalogue.zip &>>/tmp/roboshop.log && mv catalogue-main catalogue
STAT $?

HEAD "install Nodejs Depedncies"
cd /home/roboshop/catalogue && npm install --unsafe-perm &>>/tmp/roboshop.log
STAT $?

HEAD "Fix permisions to App conent"
chown roboshop:roboshop /home/roboshop -R
STAT $?
