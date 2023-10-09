#!/bin/bash

COMPONENT=shipping

#This is how we import the function that was declared in a different file using source
source components/common.sh
JAVA

echo -e "\e[35m ${COMPONENT} installation is completed \e[0m \n"