#!/bin/bash 

COMPONENT=$1
INSTANCE_TYPE="t2.micro"
Hosted_Zone_ID="Z0352998G9DBZC0H61N5"


if [ -z $1 ]; then
    echo -e "\e[31m Component name is needed \e[0m \n \t \t"
    echo -e "\e[35m Ex usage \e[0m \n\t\t $ bash launch ec2 "
    exit 1
fi 

AMI_ID="$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq ".Images[].ImageId" | sed -e 's/"//g')"
SG_ID="$(aws ec2 describe-security-groups --filters Name=group-name,Values=b55-allow-all | jq ".SecurityGroups[].GroupId" | sed -e 's/"//g')"

create_ec2() {
echo -e "***** CREATING \e35m ${COMPONENT} \e[0m server is in progress *****"
PRIVATEIP=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE}  --security-group-ids ${SG_ID} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')

echo -e "Private IP Address of $COMPONENT is $PRIVATEIP \n\n"

#Each & every resource we create in Ent will have tags
sed -e "s/COMPONENT/${COMPONENT}/" -e "s/IPADDRESS/${PRIVATEIP}/" route53.json > /tmp/r53.json 
aws route53 change-resource-record-sets --hosted-zone-id $Hosted_Zone_ID --change-batch file:///tmp/r53.json 
echo -e "Private IP address of the $COMPONENT is created and ready to use on ${COMPONENT}.roboshop.internal"

echo -e "****** CREATING DNS record for $COMPONENT has been completed *****"
}

if [ "$1" == "all" ]; then 
    for component in mongodb catalogue cart user shipping frontend payment mysql  redit rabbitmq; do 
        COMPONENT=$component 
        create_ec2
    done

else
        create_ec2

fi 
