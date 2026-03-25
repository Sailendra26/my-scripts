#!/bin/bash

USER_ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="/var/log/shell-scripting-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOG_FOLDER

if [ $USER_ID -ne 0 ]; then
    echo -e " $R ERROR: please run wuth user privileges $N" 
    exit 1
fi 

VALIDATE() {

    if [ $1 -ne 0 ]; then
        echo -e " $2  ...$R FAILURE $N"
        exit 1
    else
        echo -e " $2... $G SUCCESS $N "
    fi
}

cp mongo.repo /etc/yum.repos.d/
VALIDATE $? "Adding Mongo repo"

dnf install mongodb-org -y &>> $LOG_FILE
VALIDATE $? "installing mongoDB"

dnf install mongodb-mongosh -y &>> $LOG_FILE
VALIDATE $? "installing mongodb client"

systemctl enable mongod &>> $LOG_FILE
VALIDATE $? "Enable mongoDB"

systemctl start mongod 
VALIDATE $? "Start mongoDB"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "Allowing remote connections to MongoDB"

systemctl restart mongod &>> $LOG_FILE
VALIDATE $? "Restarted MongoDB"