#!/bin/bash

# Check if a checksum file is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <checksum_file>"
    exit 1
fi

checksum_file="$1"

# Check if the provided checksum file exists
if [ ! -f "$checksum_file" ]; then
    echo "Error: Checksum file '$checksum_file' not found."
    exit 1
fi

# Variables to track success/failure
all_checksums_matched=true
any_mismatch=false

# Verify checksums
while read -r expected_checksum filename; do
    if [ -f "$filename" ]; then
        actual_checksum=$(sha256sum "$filename" | awk '{print $1}')
        if [ "$expected_checksum" == "$actual_checksum" ]; then
            echo "Checksum matched: $filename"
        else
            echo "Checksum mismatch: $filename"
            all_checksums_matched=false
            any_mismatch=true
        fi
    else
        echo "File not found: $filename"
        all_checksums_matched=false
        any_mismatch=true
    fi
done < "$checksum_file"

# Display result message
if $all_checksums_matched; then
    echo -e "\nAll checksums matched. Verification successful."
else
    if $any_mismatch; then
        echo -e "\nATTENTION: Checksum verification failed for some files. Some downloaded files may be corrupted."
    else
        echo -e "\nERROR: No checksums to verify."
    fi
    exit 1
fi