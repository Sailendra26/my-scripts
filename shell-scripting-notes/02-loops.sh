#!/bin/bash

USER_ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="/var/log/shell-scripting-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE=$($LOG_FOLDER/$SCRIPT_NAME.log)

mkdir -p $LOG_FOLDER

if [ $USER_ID -ne 0]; then
    echo " $R ERROR: please run wuth user privileges $N" 
    exit 1
fi 

VALIDATE() {
    if [$1 -ne 0]; then
        echo " $2 installation is ...$G FAILURE $N"
        exit 1
    else
        echo " $2 intstallation is ... $R SUCCESS $N "
    fi
}


for package in $@
do
    dnf list installed $package &>> $LOG_FILE
    if [ $? -ne 0]; then
        dnf list installed $package -y &>> $LOG_FILE
        VALIDATE $? "$package"
    else
        echo "$package is alreay exists..$Y SKIPPING $N"
    fi
done