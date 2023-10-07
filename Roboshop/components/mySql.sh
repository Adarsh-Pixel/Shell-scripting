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

echo -n "Extracting the default mysql root password :"
DEFAULT_ROOT_PASSWORD=$(grep 'temporary password'  /var/log/mysqld.log | awk -F " " '{print $NF}')
stat $?

#This should happen only once and that too for the first time, when it runs for the second time the jobs fail
#We need to ensure that this runs only once
echo "show databases;" | mysql -uroot -pRoboShop@1 &>> ${LOGFILE}
if [ $? -ne 0 ]; then 
        echo -n "Performing default password reset of root action:"
        echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1'" | mysql --connect-expired-password -uroot -p$DEFAULT_ROOT_PASSWORD &>> ${LOGFILE}
        stat $?
fi 

echo "show plugins;" | mysql -uroot -pRoboShop@1 | grep validate_password &>> ${LOGFILE}
if [ $? -eq 0 ]; then
        echo -n "Uninstalling password-validate plugin :"
        echo "uninstall plugin validate_password" | mysql -uroot -pRoboShop@1 &>> ${LOGFILE}
        stat $?
fi