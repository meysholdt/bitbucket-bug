#!/bin/bash

# Check if the filename is passed as a parameter
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 filename"
  exit 1
fi

# Assign the filename to a variable
filename=$1

# Loop over each line in the file
while IFS= read -r line; do
  # Execute check.sh with the current line as argument and capture the output
  output=$(./check.sh "$line")
  
  # Print the line and the output of check.sh
  echo "$line: $output"
done < "$filename"
