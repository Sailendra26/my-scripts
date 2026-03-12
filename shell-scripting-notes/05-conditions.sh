#!/bin/bash

NUMBER=5

if [ $NUMBER -lt 20 ]; then
    echo " this number $NUMBER is less than 20 "
elif [ $NUMBER -gt 20 ]; then
    echo " this number $NUMBER is greater than 20 "
else
    echo " this number $NUMBER is equal to 20 "
fi
