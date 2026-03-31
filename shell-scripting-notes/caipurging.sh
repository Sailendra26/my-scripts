#!/bin/bash

SOURCE_DIR="/gpc/purge/download/nonemp/wgs"
BASE_DEST_DIR="/gpc/purge/download/nonemp/wgs/archive"
LOG_DIR="/gpc/purge/download/nonemp/wgs/archive/log"

# Create log directory if not exists
# mkdir -p "$LOG_DIR"

# Get current date components
CURRENT_YEAR=$(date +%Y)
CURRENT_MONTH=$(date +%m)

# Determine quarter
if [ $CURRENT_MONTH -ge 1 ] && [ $CURRENT_MONTH -le 3 ]; then
    QUARTER="Q1"
elif [ $CURRENT_MONTH -ge 4 ] && [ $CURRENT_MONTH -le 6 ]; then
    QUARTER="Q2"
elif [ $CURRENT_MONTH -ge 7 ] && [ $CURRENT_MONTH -le 9 ]; then
    QUARTER="Q3"
else
    QUARTER="Q4"
fi

# Create quarterly folder
QUARTER_FOLDER="${QUARTER}${CURRENT_YEAR}"
DEST_DIR="${BASE_DEST_DIR}/${QUARTER_FOLDER}"

mkdir -p "$DEST_DIR" || { echo "Failed to create destination $DEST_DIR"; exit 1; }

# Get .bkp files modified in last 1–30 days
file_list=$(find "$SOURCE_DIR" -maxdepth 1 -type f -name "*.bkp" -mtime -30 -mtime +0)

if [ -z "$file_list" ]; then
    echo "No .bkp files from last 1–30 days found."
    exit 0
fi

file_count=$(echo "$file_list" | wc -l)
counter=0

echo "Starting compression of $file_count files..."

# Loop through each .bkp file
for file in $file_list; do
    if [ -f "$file" ]; then
        counter=$((counter + 1))

        filename=$(basename "$file")             # clmdb01.bkp
        filename_no_ext="${filename%.bkp}"       # clmdb01
        current_date=$(date +%d%m%Y)

        zip_name="${filename_no_ext}_${current_date}.zip"
        log_file="${LOG_DIR}/${filename_no_ext}_log_${current_date}.log"

        # Start log for this file
        echo "Log for $filename - $(date)" > "$log_file"
        echo "----------------------------------------" >> "$log_file"
        echo "Processing: $file" >> "$log_file"
        echo "Destination ZIP: $DEST_DIR/$zip_name" >> "$log_file"
        echo "" >> "$log_file"

        echo "[$counter/$file_count] Compressing $filename → $zip_name"

        # Try compressing
        zip -j "$DEST_DIR/$zip_name" "$file" >> "$log_file" 2>&1

        if [ $? -eq 0 ]; then
            echo "SUCCESS: File zipped successfully" >> "$log_file"
            echo "SUCCESS: $zip_name created."
        else
            echo "FAILED: Error during compression" >> "$log_file"
            echo "FAILED to create $zip_name."
        fi

        echo "----------------------------------------" >> "$log_file"
        echo "Log saved: $log_file"
        echo ""

    fi
done

echo "All files processed successfully."