#!/bin/bash 

USER_ID=$(id -u)

LOG_FOLDER="/var/log/shell-script-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)  # it will remove the .sh so the script name will be "Task"
LOG_FILE=$LOG_FOLDER/$SCRIPT_NAME.log   # here you are adding the .log to the script name so the name will be "Task.log"

mkdir -p $LOG_FOLDER # It checks first if the folder is exist, if not then it will create the folder

echo " Script started and executed on : $(date) "

if [ $USER_ID -ne 0 ]; then
	echo " ERROR:: please run the script with user privileges "
	exit 1
fi


VALIDATE() {

if [ $1 -ne 0 ]; then
	echo " $2 installation is.. FAILED "
	exit 1
else
	echo " $2 installation is.. SUCCESS "
fi
}


dnf list installed nginx &>> $LOG_FILE

if [ $? -ne 0 ]; then
	dnf install nginx -y &>> $LOG_FILE
	VALIDATE $? "nginx"
else
	echo " nginx is already exists...SKIPPING " | tee -a $LOG_FILE
fi

dnf list installed mysql &>> $LOG_FILE

if [ $? -ne 0 ]; then 
	dnf install mysql -y &>> $LOG_FILE
	VALIDATE $? "mysql"
else
	echo " mysql already exists...SKIPPING " | tee -a $LOG_FILE
fi