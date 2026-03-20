#!/bin/bash

# set -euo pipefail

trap 'echo "ERROR at line $LINENO: $BASH_COMMAND"' ERR

echo "Starting..."

echo "hello" | grep "abc" | wc -l

echo "After pipe"