#!/bin/bash

set -euo pipefail

# echo "Hello.."
# echo "Before error.."
# ccaffjl;dnf 
# echo "After error"

echo "Starting..."
echo "hello" | grep "abc" | wc -l
echo "After pipe"