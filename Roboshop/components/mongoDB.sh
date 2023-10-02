#!/bin/bash

echo "I am mongodb"

USER_ID=$(id -u)
COMPONENT=mongodb
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
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n "installing ${COMPONENT}  :"
yum install -y mongodb-org      &>> ${LOGFILE}
stat $?

echo -n "starting the ${COMPONENT}  :"
systemctl enable mongod         &>> ${LOGFILE}
systemctl start mongod          &>> ${LOGFILE}
stat $?

echo -n "enabling the ${COMPONENT} visibility :"
sed -ie 's/127.0.0.1/0.0.0.0/g' mongod.conf
stat $?

# systemctl restart mongod

# curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"

# cd /tmp
# unzip mongodb.zip
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js