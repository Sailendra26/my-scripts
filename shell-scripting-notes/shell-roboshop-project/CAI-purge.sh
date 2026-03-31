#!/bin/bash

# if any command failes in the script then set stops the script. 
set -euo pipefail

# trap used to handle errors and display which line and command failed
# Bash excecutes each command and checks its exit status, 
# If any command returns a non-zero exit code, the "ERR trap" command gets triggered.

trap 'echo "ERROR at line $LINENO: $BASH_COMMAND"' ERR

SOURCE="/tmp/wgs"
DEST="/tmp/wgs/ARCHIVE"

mkdir -p "$SOURCE"
mkdir -p "$DEST/logs"

CURRENT_DATE=$(date +%Y-%m-%d)
START_TIME=$(date +%s)

# Quarter calculation
MONTH=$(date +%m)
YEAR=$(date +%Y)

if [ $MONTH -ge 1 ] && [ $MONTH -le 3 ]; then
    QUARTER="Q1-$YEAR"
elif [ $MONTH -ge 4 ] && [ $MONTH -le 6 ]; then
    QUARTER="Q2-$YEAR"
elif [ $MONTH -ge 7 ] && [ $MONTH -le 9 ]; then
    QUARTER="Q3-$YEAR"
else
    QUARTER="Q4-$YEAR"
fi

ARCHIVE_DIR="$DEST/$QUARTER"
LOG_FILE="$DEST/logs/$QUARTER.log"

# Create only quarter folder (ARCHIVE & logs already exist)
mkdir -p "$ARCHIVE_DIR"

echo "-----------------------------" >| tee -a $LOG_FILE

echo "script started running"

echo "Script started at $(date)" | tee -a $LOG_FILE

# Get last 30 days .bkp files
FILES=$(find "$SOURCE" -type f -name "*.bak" -mtime -30)

# Check if no .bak files found (FILES variable is empty i.e. string is empty or not )
if [ -z "$FILES" ]; then
    echo "No .bkp files found in last 30 days" | tee -a $LOG_FILE
fi

for file in $FILES
do
    filename=$(basename "$file" .bkp)
    zip_file="${filename}_${CURRENT_DATE}.zip"

    echo "Processing file: $file" | tee -a $LOG_FILE

    #Zip the file without including full path (only filename will be stored)
    zip -j "$ARCHIVE_DIR/$zip_file" "$file"

    #Check if zip file exists (created successfully)
    if [ -f "$ARCHIVE_DIR/$zip_file" ]; then
        echo "Zipped successfully: $zip_file" | tee -a $LOG_FILE

        rm -f "$file"
        echo "Deleted original file: $file" | tee -a $LOG_FILE
    else
        echo "Error zipping file: $file" | tee -a $LOG_FILE
    fi
done

END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

echo "Script ended at $(date)" >> "$LOG_FILE"
echo "Total time taken: $DURATION seconds" | tee -a $LOG_FILE

echo "script completed successfully"