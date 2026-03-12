#RED --> ERROR
#GREEN --> SUCCESS
#YELLOW --> WARNING
#WHITE --> NORMAL

Example:
--------

#!/bin/bash

# Color variables
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
NORMAL="\e[0m"

# Messages
echo -e "$RED ERROR: Something failed $NORMAL"
echo -e "$GREEN SUCCESS: Operation completed $NORMAL"
echo -e "$YELLOW WARNING: Check this step $NORMAL"
echo -e "$NORMAL INFO: Normal message $NORMAL"