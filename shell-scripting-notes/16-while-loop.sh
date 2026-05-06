#!/bin/bash

#Example-1: print 1 to 5

# i=1
# while [ $i -le 5 ]
# do
#   echo $i
#   i=$((i+1)) # Increment the count
# done


#Example-2: checking count down 

count=5
echo "Starting countdown..."
while [ $count -gt 0 ]
do
  echo "Time left: $count"
  sleep 2 # Pause for 1 second
  count=$((count - 1)) # Decrement the count
done