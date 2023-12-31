#!/bin/bash

# validate the user who is running the script is a root user or not.

USER_ID=$(id -u)
COMPONENT=frontend
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

echo -n "Installing nginx :"
yum install nginx -y &>> ${LOGFILE}
stat $?


echo -n "Starting Nginx"
systemctl enable nginx  &>> ${LOGFILE}
systemctl start nginx   &>> ${LOGFILE}
stat $?


echo -n "Downloading the ${COMPONENT} component:"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?

echo -n "Clean up of ${COMPONENT} : "
cd /usr/share/nginx/html
rm -rf *    &>> ${LOGFILE}
stat $?

echo -n "Extracting ${COMPONENT} : "
unzip /tmp/${COMPONENT}.zip &>> ${LOGFILE}
stat $?

echo -n "Sorting the ${COMPONENT} files : "
mv ${COMPONENT}-main/* .              &>> ${LOGFILE}
mv static/* .                    &>> ${LOGFILE}
rm -rf ${COMPONENT}-main README.md   &>> ${LOGFILE}  
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "updating the backend components in the reverse proxy file:"
for component in catalogue user cart shipping payment;do 
    sed -i -e "/${component}/s/localhost/${component}.roboshop.internal/" /etc/nginx/default.d/roboshop.conf
done

echo -n "restarting ${COMPONENT} :"
systemctl daemon-reload         &>> ${LOGFILE}
systemctl restart nginx         &>> ${LOGFILE}

stat $?

echo -e "\e[35m ${COMPONENT} installation is completed \e[0m \n"
stat $?