#!/bin/bash

COMPONENT=rabbitmq

source components/common.sh

echo -e "\e[35m Congiguring ${COMPONENT}.....! \e[0m \n"

echo -n "configuring ${COMPONENT} repo : "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash           &>> ${LOGFILE}
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash  &>> ${LOGFILE}
stat $?

echo -n "installing ${COMPONENT}  :"
yum install rabbitmq-server -y     &>> ${LOGFILE}
stat $?


echo -n "starting the ${COMPONENT}  :"
systemctl enable rabbitmq-server         &>> ${LOGFILE}
systemctl start rabbitmq-server         &>> ${LOGFILE}
stat $?

echo -n "Creating ${COMPONENT} user account :"
rabbitmqctl add_user roboshop roboshop123    &>> ${LOGFILE}
stat $?

echo -n "Configuring the permissions :"
rabbitmqctl set_user_tags roboshop administrator
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
stat $?


echo -e "\e[35m ${COMPONENT} installation is completed \e[0m"