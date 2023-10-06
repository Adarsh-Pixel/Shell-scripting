#!/bin/bash

COMPONENT=mysql

source components/common.sh

echo -e "\e[35m Congiguring ${COMPONENT}.....! \e[0m \n"

echo -n "configuring ${COMPONENT} repo : "
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo
stat $?

echo -n "installing ${COMPONENT}  :"
yum install mysql-community-server -y     &>> ${LOGFILE}
stat $?


echo -n "Starting ${COMPONENT}"
systemctl enable mysqld  &>> ${LOGFILE}
systemctl start mysqld   &>> ${LOGFILE}
stat $?