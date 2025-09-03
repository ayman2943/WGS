#!/bin/bash

# Check if FastQC is installed
if ! command -v fastqc &> /dev/null
then
    echo "FastQC could not be found. Please install it and try again."
    exit
fi

# Create a directory for FastQC output if it doesn't exist
output_dir="fastqc_output"
mkdir -p $output_dir

# Run FastQC on all fastq.gz files in the current directory
for file in *.fastq.gz
do
    echo "Running FastQC on $file..."
    fastqc -o $output_dir $file
done

echo "FastQC analysis complete. Output files are in the $output_dir directory."

