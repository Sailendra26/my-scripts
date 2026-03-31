#!/bin/bash

# EC2 TEST PATHS
SOURCE_DIR="$HOME/test/wgs"
BASE_DEST_DIR="$HOME/test/wgs/ARCHIVE"
LOG_DIR="$HOME/test/wgs/ARCHIVE/logs"

# Create required folders
mkdir -p "$SOURCE_DIR"
mkdir -p "$BASE_DEST_DIR"
mkdir -p "$LOG_DIR"

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
QUARTER_FOLDER="${QUARTER}-${CURRENT_YEAR}"
DEST_DIR="${BASE_DEST_DIR}/${QUARTER_FOLDER}"

mkdir -p "$DEST_DIR" || { echo "Failed to create destination $DEST_DIR"; exit 1; }

# Get .bkp files (last 30 days)
file_list=$(find "$SOURCE_DIR" -maxdepth 1 -type f -name "*.bkp" -mtime -30)

if [ -z "$file_list" ]; then
    echo "No .bkp files found."
    exit 0
fi

file_count=$(echo "$file_list" | wc -l)
counter=0

echo "Starting compression of $file_count files..."

# Loop through files
for file in $file_list; do

    if [ -f "$file" ]; then
        counter=$((counter + 1))

        filename=$(basename "$file")
        filename_no_ext="${filename%.bkp}"
        current_date=$(date +%Y-%m-%d)

        zip_name="${filename_no_ext}_${current_date}.zip"
        log_file="${LOG_DIR}/${filename_no_ext}_log_${current_date}.log"

        # Start log
        echo "Log for $filename - $(date)" > "$log_file"
        echo "-----------------------------------" >> "$log_file"
        echo "Source: $file" >> "$log_file"
        echo "Destination ZIP: $DEST_DIR/$zip_name" >> "$log_file"
        echo "" >> "$log_file"

        echo "[$counter/$file_count] Compressing $filename → $zip_name"

        # Zip
        zip -j "$DEST_DIR/$zip_name" "$file" >> "$log_file" 2>&1

        if [ $? -eq 0 ]; then
            echo "SUCCESS: File zipped successfully" >> "$log_file"

            rm -f "$file"
            echo "Deleted original file: $file" >> "$log_file"
        else
            echo "FAILED: Error during compression" >> "$log_file"
        fi

        echo "-----------------------------------" >> "$log_file"
        echo "Log saved: $log_file"
        echo ""
    fi

done

echo "All files processed successfully."