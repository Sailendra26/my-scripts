#!/bin/bash


USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
	echo " ERROR:: please run with ROOT permissions "
	exit 2
fi


VALIDATE() {

	if [ $1 -ne 0 ]; then
		echo " $2 installation is failed "
		exit 1
	else 
		echo " $2 installation is SUCCESS "
		
	fi
	
}


dnf list installed nginx

# Install nginx only if it is not installed - this is just a COMMENT for readability 

if [ $? -ne 0 ]; then
	dnf install nginx -y
	VALIDATE $? "nginx"
	
else
	echo " nginx is already exists "
fi


dnf list installed mysql 

# Install mysql only if it is not installed - this is just a COMMENT for readability 


if [ $? -ne 0 ]; then
	dnf install mysql -y 
	VALIDATE $? "mysql"
	
else 
	echo " mysql is already exists "
	
fi
	