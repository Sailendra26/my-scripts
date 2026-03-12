#!/bin/bash

v1=kiran
v2=hari
touch file1
echo " exit status of last command: " $?
echo " script name is : " $0
echo " "
echo " PID of the script is : $$"
echo " $info "
echo " $v1: hi $v2, are u practicing shell-script "
echo " $v2: hi $v1, yes i am "
read -s -t 10 -p " enter your password: " password
echo " "
echo " "
echo " exit status of password is: " $?
echo " first argument : " $1
echo " second argument : " $2
echo " total arguments count : " $#
echo " Display all arguments: " $@
