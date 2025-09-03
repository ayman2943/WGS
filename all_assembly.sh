#!/bin/bash

# Output directory for assembly results
ASSEMBLY_DIR="./assembly"
mkdir -p "${ASSEMBLY_DIR}"

# Loop through each pair of trimmed FASTQ files
for r1 in ./trimmed/*_R1_trimmed.fastq.gz
do
    # Get the base name of the R1 file
    base=$(basename "${r1}" _R1_trimmed.fastq.gz)
    
    # Check if corresponding R2 file exists
    r2="./trimmed/${base}_R2_trimmed.fastq.gz"
    if [ ! -e "${r2}" ]; then
        echo "Error: Missing corresponding R2 file for ${r1}"
        continue
    fi

    # Define output directory for this sample
    SAMPLE_DIR="${ASSEMBLY_DIR}/${base}"
    mkdir -p "${SAMPLE_DIR}"

    # Run SPAdes assembly
    spades.py \
        -1 "${r1}" \
        -2 "${r2}" \
        -o "${SAMPLE_DIR}" \
        -t 4 \
        --isolate \
        --cov-cutoff auto \
        -k 21,33,55,71,105,121,125,127
    echo "Assembly for ${base} completed."
done

