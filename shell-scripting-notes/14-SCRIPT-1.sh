#!/bin/bash

# Calling one script from another script

EVERYTHING="SHIVA"

echo " I love : $EVERYTHING "
echo "PID of SCRIPT-1: $$"

source ./15-SCRIPT-2.sh
