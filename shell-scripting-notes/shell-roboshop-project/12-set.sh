#!/bin/bash

set -euo pipefail

# error(){
#     echo "There is an error in $LINENO, Command is: $BASH_COMMAND"
# }

echo "Hello.."
echo "Before error.."
ccaffjl;dnf # here shell understands there is an error and signal is ERR
echo "After error"