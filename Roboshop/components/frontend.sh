#!/bin/bash

# validate the user who is running the script is a root user or not.

USER_ID=$(id -u)

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
    exit 2
}

echo -e "\e[35m Congiguring frontend.....! \e[0m \n"

echo -n "Installing frontend :"
yum install nginx -y &>> /tmp/frontend.log
stat $?


echo -n "Starting Nginx"
systemctl enable nginx  &>> /tmp/frontend.log
systemctl start nginx   &>> /tmp/frontend.log
stat $?


echo -n "Downloading the frontend component:"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $?

echo -n "Clean up of frontend : "
cd /usr/share/nginx/html
rm -rf *    &>> /tmp/frontend.log
stat $?

echo -n "Extracting frontend : "
unzip /tmp/frontend.zip &>> /tmp/frontend.log
stat $?

echo -n "Sorting the frontend files : "
mv frontend-main/* .              &>> /tmp/frontend.log
mv static/* .                    &>> /tmp/frontend.log
rm -rf frontend-main README.md   &>> /tmp/frontend.log   
mv localhost.conf /etc/nginx/default.d/roboshop.conf

# yum install nginx -y
# systemctl enable nginx
# systemctl start nginx

# curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf
