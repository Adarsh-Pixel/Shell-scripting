#!/bin/bash

echo "I am catalogue"

USER_ID=$(id -u)
COMPONENT=catalogue
LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"

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
curl --silent --location https://rpm.nodesource.com/setup_16.x |  bash - &>> ${LOGFILE}
stat $?

echo -n "installing ${COMPONENT}  :"
yum install nodejs -y      &>> ${LOGFILE}
stat $?

id ${APPUSER}       &>> ${LOGFILE}
if [ $? -ne 0 ] ; then
    echo -n "Creating application user account :"
    useradd roboshop
    stat $?
fi 

echo -n "Downloading the ${COMPONENT} Schema :"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?


echo -n "Copying  the ${COMPONENT} to ${APPUSER} home directory :"
cd /home/${APPUSER}/
rm -rf ${COMPONENT}           &>> ${LOGFILE}
unzip -o /tmp/${COMPONENT}.zip     &>> ${LOGFILE}
stat $?

echo -n "changing the ownership :"
mv ${COMPONENT}-main ${COMPONENT}
chown -R ${APPUSER}:${APPUSER} /home/${APPUSER}/${COMPONENT}
stat $?

echo -n "generating the ${COMPONENT} artifacts :"
cd /home/${APPUSER}/${COMPONENT}/
npm install             &>> ${LOGFILE}
stat $?


# cd /tmp
# unzip -o ${COMPONENT}.zip        &>> ${LOGFILE}
# stat $?

# echo -n "Injecting the ${COMPONENT} Schema :"
# cd ${COMPONENT}-main         
# mongo < catalogue.js        &>> ${LOGFILE}
# mongo < users.js            &>> ${LOGFILE}
# stat $?


# echo -e "\e[35m ${COMPONENT} installation is completed \e[0m"