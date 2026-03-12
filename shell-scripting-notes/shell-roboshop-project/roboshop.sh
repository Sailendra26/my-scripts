#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-07c8acf3fa6b923fa" # replace with your SG-ID
ZONE_ID="Z04223522WLWW3RAUWSAN" # this is your Hosted zone-ID
DOMAIN_NAME="devopsmegham.fun" # this is your domain name 

for instance in $@ # mongodb redis mysql : Instance names
do
   # This will create an instance and give you the instance ID
        INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --instance-type t3.micro --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query 'Instances[0].InstanceId' --output text)


    # Get Private IP
    if [ $instance -ne "frontend" ]; then

    # This will give your instance Private-ip address if your insatnce is not "frontend"
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
        RECORD_NAME="$instance.$DOMAIN_NAME" # mongodb.daws86s.fun
    else

    # This will give your instance Public-ip address if your insatnce is "frontend"
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
        RECORD_NAME="$DOMAIN_NAME" # daws86s.fun
    fi

    echo "$instance: $IP"

    aws route53 change-resource-record-sets \
    --hosted-zone-id $ZONE_ID \
    --change-batch '
    {
        "Comment": "Updating record set"
        ,"Changes": [{
        "Action"              : "UPSERT"
        ,"ResourceRecordSet"  : {
            "Name"              : "'$RECORD_NAME'"
            ,"Type"             : "A"
            ,"TTL"              : 1
            ,"ResourceRecords"  : [{
                "Value"         : "'$IP'"
            }]
        }
        }]
    }
    '
done