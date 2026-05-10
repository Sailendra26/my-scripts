#!/bin/bash

# when you read the file with this "IFS= read -r" IFS keeps the leading/trailing spaces as it is 
# -r keeps the backslashes as it is 

# while IFS= read -r line 
# do
#   echo "processing line:$line"
# done < ./15-SCRIPT-2.sh

# when you read the file normally it will remove the leading/trailing spaces and backslashes


while read line
do
  echo "processing line:$line"
done < ./15-SCRIPT-2.sh