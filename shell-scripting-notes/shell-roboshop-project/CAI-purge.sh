#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

# if any command fails in the script then set stops the script. 
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
LOG_FILE="$DEST/logs/cai-archive.log"

# Create only quarter folder 
mkdir -p "$ARCHIVE_DIR"

echo "-----------------------------" | tee -a "$LOG_FILE"
echo -e "Script started at $G $(date) $N" | tee -a "$LOG_FILE"

# Get last 30 days .bak files
FILES=$(find "$SOURCE" -type f -name "*.bak" -mtime -30)

# Check if no .bak files found (FILES variable is empty i.e. string is empty or not )
if [ -z "$FILES" ]; then
    echo -e "$Y No .bak files found in last 30 days $N" | tee -a "$LOG_FILE"
    exit 0
fi

#Zip the file without including full path (only filename will be stored, it will ignore the file)
echo -e "zip package validation.. $G STARTED $N"

VALIDATE() {
    if [ $1 -eq 0 ]; then
        echo "$2 installed successfully" | tee -a "$LOG_FILE"
    else
        echo "$2 installation failed" | tee -a "$LOG_FILE"
        exit 1
    fi
}

if dnf list installed zip &> /dev/null; then
    echo "zip is already installed -- SKIPPING" | tee -a "$LOG_FILE"
else
    echo "zip is not installed, installing..." | tee -a "$LOG_FILE"
    sudo dnf install zip -y &> /dev/null
    VALIDATE $? "zip"
fi

echo -e "zip package validation.. $G COMPLETED $N"

for file in $FILES
do
    # It removes path and .bak extension and takes the only file name
    filename=$(basename "$file" .bak)
    zip_file="${filename}_${CURRENT_DATE}.zip"

    echo "Processing file: $file" | tee -a "$LOG_FILE"

    echo -e "File zipping $G STARTED $N"

    zip -j "$ARCHIVE_DIR/$zip_file" "$file"

    #Check if zip file exists 
    if [ -f "$ARCHIVE_DIR/$zip_file" ]; then
        echo -e "File Zipped $G ..successfully $N: $zip_file" | tee -a "$LOG_FILE"
        rm -f "$file"
        echo -e "Deleted original file: $file $G ..SUCCESSFULLY $N" | tee -a "$LOG_FILE"
    else
        echo -e "Error zipping file: $file $R ..FAILED $N" | tee -a "$LOG_FILE"
    fi
done

END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

echo -e "$N Script ended at $(date) $N" | tee -a "$LOG_FILE"
echo -e "$N Total time taken: $DURATION seconds $N" | tee -a "$LOG_FILE"
echo -e "script completed $G ..successfully $N"