#!/bin/bash

# Check if a directory path and an output file name are provided as arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <directory_path> <output_checksum_file>"
    exit 1
fi

directory="$1"
output_checksum_file="$2"

# Check if the provided path is a valid directory
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' not found."
    exit 1
fi

# Find all zip files recursively and calculate their SHA-256 checksums
find "$directory" -type f -name "*.zip" -print0 | while IFS= read -r -d $'\0' file; do
    checksum=$(sha256sum "$file" | awk '{print $1}')
    echo "$checksum  $file"
done > "$output_checksum_file"

echo "Checksums saved to '$output_checksum_file'"