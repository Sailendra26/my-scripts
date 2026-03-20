#!/bin/bash

set -euo pipefail

echo "Hello.."
echo "Before error.."
ccaffjl;dnf # here shell understands there is an error and signal is ERR
echo "After error"