#!/bin/bash

set -euo pipefail

echo "Starting..."

echo "hello" | grep "abc" | wc -l

echo "After pipe"