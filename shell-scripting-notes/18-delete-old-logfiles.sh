#!/bin/bash

USER_ID=$(id -u)
# root-userId = 0
# ec2-userId = 1001

LOG_FOLDER="/var/log/shell-script-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1) # output is delete-old-logfiles
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log" # output is delete-old-logfiles.log

if [ $USER_ID -ne 0 ]; then
    echo "ERR: Please run with sudo permissions"
    exit 1
fi

mkdir -p $LOG_FOLDER
echo "script started at: $(date)"

SOURCE_DIR="/home/ec2-user/app-logs"
mkdir -p $SOURCE_DIR

if [ ! -d $SOURCE_DIR ]; then
    echo "ERR: $SOURCE_DIR is not exist"
    exit 1
fi

FILES=$( find $SOURCE_DIR -name "*.log" -type f -mtime +10 )

while IFS= read -r filepath
do
    echo " Deleting the file: $filepath "
    rm -rf $filepath
    echo " Deleted the file: $filepath "
done <<< $FILES



