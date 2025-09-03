#!/bin/bash

# Check if MultiQC is installed
if ! command -v multiqc &> /dev/null
then
    echo "MultiQC could not be found. Please install it and try again."
    exit
fi

# Define the output directory for FastQC results
fastqc_output_dir="fastqc_output"

# Check if the FastQC output directory exists
if [ ! -d "$fastqc_output_dir" ]; then
    echo "The FastQC output directory ($fastqc_output_dir) does not exist. Please run FastQC first."
    exit 1
fi

# Run MultiQC on the FastQC results and generate only the HTML report
echo "Running MultiQC on FastQC results..."
multiqc --filename multiqc_report.html $fastqc_output_dir

echo "MultiQC analysis complete. Check the multiqc_report.html file in the current directory."

