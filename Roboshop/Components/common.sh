HEAD(){
  echo -n -e "\e[1m $1 \e[0m \t\t......"
  }

 STAT() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[1;32m done\e[0m"
  else
    echo -e "\e[1;31m fail\e[0m"
    echo -e "\e[1;33m check the log for more details ...Log-File : /tmp/roboshop.log\e[0m"
    exit 1
  fi
}
NODEJS(){
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
  curl -s -L -o /tmp/$1.zip "https://github.com/roboshop-devops-project/$1/archive/main.zip" &>>/tmp/roboshop.log
  STAT $?

  HEAD "Extract the Downloaded file"
  cd /home/roboshop && rm -rf $1 && unzip /tmp/$1.zip &>>/tmp/roboshop.log && mv $1-main $1
  STAT $?

  HEAD "install Nodejs Depedncies"
  cd /home/roboshop/$1 && yum install npm -y &>>/tmp/roboshop.log
  STAT $?

  HEAD "Fix permisions to App conent"
  chown roboshop:roboshop /home/roboshop -R
  STAT $?

  HEAD "Update DNS Records in SystemD fie"
  STAT $?

  HEAD "Setup SystemD Service"
  sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/REDIS_MONGO_ENDPOINTENDPOINT/redis.roboshop.internal/' -e 's//mongodb.roboshop.internal/' /home/roboshop/$1/systemd.service && mv /home/roboshop/$1/systemd.service /etc/systemd/system/$1.service
  STAT $?

  HEAD "Start Catalogue Service"
  systemctl daemon-reload && systemctl enable $1 &>>/tmp/roboshop.log && systemctl restart $1  &>>/tmp/roboshop.log
  STAT $?
}