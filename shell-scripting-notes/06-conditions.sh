#!/bin/bash

echo "enter your number"
read NUMBER

if [ $((NUMBER%2)) -eq 0 ]; then
	echo " this number $NUMBER is even "
else
	echo " this number $NUMBER is odd "
fi

