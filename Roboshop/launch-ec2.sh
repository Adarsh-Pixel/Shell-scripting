#!/bin/bash 

# To create a server what all information needed: 
# 1) AMI ID
# 2) Type of Instance
# 3) Security Group
# 4) Instances you need
# 5) DNS_Record : Hosted_Zone_ID

COMPONENT=$1
if [ -z $1 ]; then
    echo -e "\e[31m Component name is needed \e[0m \n \t \t"
    echo -e "\e[35m Ex usage \e[0m \n\t\t $ bash launch ec2 "
    exit 1
fi 

# AMI_ID="ami-0c1d144c8fdd8d690"
AMI_ID="$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq ".Images[].ImageId" | sed -e 's/"//g')"
INSTANCE_TYPE="t2.micro"
SG_ID="sg-03e9f6f3171da279d"

echo -e "***** CREATING \e35m ${COMPONENT} \e[0m server is in progress *****"
PRIVATEIP=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE}  --security-group-ids ${SG_ID} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')

echo -e "Private IP Address of $COMPONENT is $PRIVATEIP"

#Each & every resource we create in Ent will have tags
