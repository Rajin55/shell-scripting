#!/bin/bash

source Components/common.sh
rm -f /tmp/roboshop.log
#set-hostname mysql

HEAD "Setup MYSQL Repo"
echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo
STAT $?

HEAD "Install Mysql Service"
yum remove mariadb-libs -y &>>/tmp/roboshop.log && yum install mysql-community-server -y &>>/tmp/roboshop.log
STAT $?

HEAD "Start MYSQL Service"
systemctl enable mysqld &>>/tmp/roboshop.log && systemctl start mysqld &>>/tmp/roboshop.log