#!/bin/bash

# while IFS= read -r line
# do
#   echo "processing line:$line"
# done < ./15-SCRIPT-2.sh

while read line
do
  echo "processing line:$line"
learning
done < ./15-SCRIPT-2.sh