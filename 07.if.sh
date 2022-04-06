#!/bin/bash

read -p "Enter Username:" username

if [ "$username" == "root" ];then
   echo "Hey,user $username is admin user"
else
  echo "Hey, user $username is Normal user"
fi