#!/bin/bash

echo "I am catalogue"

USER_ID=$(id -u)
COMPONENT=catalogue
LOGFILE="/tmp/${COMPONENT}.log"

if [ $USER_ID -ne 0 ] ; then
    echo -e "\e[31m Script is expected to be executed by the root user or with a sudo privilage \e[0m \n \t Example: \n\t\t sudo bash wrapper.sh frontend"
    exit 1
fi

stat () {
    if [ $1 -eq 0 ]; then
    echo -e "\e[32m success \e[0m"
else
    echo -e "\e[31m failure \e[0m"
    fi 
}

echo -e "\e[35m Congiguring ${COMPONENT}.....! \e[0m \n"

echo -n "configuring ${COMPONENT} repo : "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
stat $?

echo -n "installing ${COMPONENT}  :"
yum install nodejs -y      &>> ${LOGFILE}
stat $?

echo -e "Creating application user account :"
useradd roboshop
stat $?

# echo -n "enabling the ${COMPONENT} visibility :"
# sed -ie 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
# stat $?

# echo -n "starting the ${COMPONENT}  :"
# systemctl enable mongod         &>> ${LOGFILE}
# systemctl start mongod          &>> ${LOGFILE}
# stat $?

# echo -n "Downloading the ${COMPONENT} Schema :"
# curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
# stat $?

# echo -n "Extracting the ${COMPONENT} Schema :"
# cd /tmp
# unzip -o ${COMPONENT}.zip        &>> ${LOGFILE}
# stat $?

# echo -n "Injecting the ${COMPONENT} Schema :"
# cd ${COMPONENT}-main         
# mongo < catalogue.js        &>> ${LOGFILE}
# mongo < users.js            &>> ${LOGFILE}
# stat $?


# echo -e "\e[35m ${COMPONENT} installation is completed \e[0m"