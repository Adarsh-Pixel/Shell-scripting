# All the common functions will be declared here. Rest of the components will be sourcing the funtions from this file. 

LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"

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
}

# funtion to create a user account
CREATE_USER() {
        id ${APPUSER}       &>> ${LOGFILE}
        if [ $? -ne 0 ] ; then
            echo -n "Creating application user account :"
            useradd roboshop
            stat $?
        fi 
}

DOWNLOAD_AND_EXTRACT() {
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
}

CONFIG_SVC(){

        echo -n "configuring the ${COMPONENT} system file :"
        sed -i -e 's/CARTENDPOINT/cart.roboshop.internal/'  -e 's/DBHOST/mysql.roboshop.internal/' /home/${APPUSER}/${COMPONENT}/systemd.service
        mv /home/${APPUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
        stat $?

        echo -n "starting the ${COMPONENT} service :"
        systemctl daemon-reload ${COMPONENT}    &>> ${LOGFILE}
        systemctl enable ${COMPONENT}           &>> ${LOGFILE}
        systemctl restart ${COMPONENT}          &>> ${LOGFILE}
        stat $?

}
# Declaring a Nodejs funtion
NODEJS() {
    
        echo -e "\e[35m Congiguring ${COMPONENT}.....! \e[0m \n"

        echo -n "configuring ${COMPONENT} repo : "
        curl --silent --location https://rpm.nodesource.com/setup_16.x |  bash - &>> ${LOGFILE}
        stat $?

        echo -n "installing ${COMPONENT}  :"
        yum install nodejs -y      &>> ${LOGFILE}
        stat $?

        CREATE_USER          # calls CREATE_USER funtion that creates user account

        DOWNLOAD_AND_EXTRACT #Downloads and extracts the components

        echo -n "generating the ${COMPONENT} artifacts :"
        cd /home/${APPUSER}/${COMPONENT}/
        npm install             &>> ${LOGFILE}
        stat $?

        CONFIG_SVC

}

MVN_PACKAGE() {
        echo -n "generating the ${COMPONENT} artifacts :"
        cd /home/${APPUSER}/${COMPONENT}/
        mvn clean package               &>> ${LOGFILE}
        mv target/shipping-1.0.jar shipping.jar
        stat $?
}

JAVA() {
        echo -e "\e[35m Congiguring ${COMPONENT}.....! \e[0m \n"

        echo -n "Installing Maven:"
        yum install maven -y          &>> ${LOGFILE}
        stat $?

        CREATE_USER

        DOWNLOAD_AND_EXTRACT

        MVN_PACKAGE

        CONFIG_SVC

}

PYTHON() {
        echo -e "\e[35m Congiguring ${COMPONENT}.....! \e[0m \n"

        echo -n "Installing Python:"
        yum install python36 gcc python3-devel -y          &>> ${LOGFILE}
        stat $?

        CREATE_USER

        DOWNLOAD_AND_EXTRACT

        echo -n "Generating the artifacts :"
        cd /home/${APPUSER}/${COMPONENT}/
        pip3 install -r requirements.txt       &>> ${LOGFILE} 
        stat $?

        USERID=$(id -u roboshop)
        GROUPID=$(id -g roboshop)

        echo -n "Updating the uid and gid in the ${COMPONENT}.ini file"
        sed -i -e "/^uid/ c uid=$(USERID)" -e "/^gid/ c gid=$(GROUPID)" /home/${APPUSER}/${COMPONENT}/${COMPONENT}.ini 

        CONFIG_SVC
}