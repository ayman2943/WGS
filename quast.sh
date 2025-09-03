#!/bin/bash

# Directory containing SPAdes assembly results
ASSEMBLY_DIR="./assembly"

# Output directory for QUAST results
QUAST_DIR="./quast_results"
mkdir -p "${QUAST_DIR}"

# Loop through each sample assembly directory
for sample_dir in "${ASSEMBLY_DIR}"/*
do
    if [ -d "${sample_dir}" ]; then
        # Get the base name of the sample directory
        sample=$(basename "${sample_dir}")
        
        # Check if contigs file exists
        contigs="${sample_dir}/contigs.fasta"
        if [ ! -e "${contigs}" ]; then
            echo "Error: Missing contigs file for ${sample}"
            continue
        fi

        # Define output directory for this sample
        SAMPLE_QUAST_DIR="${QUAST_DIR}/${sample}"
        mkdir -p "${SAMPLE_QUAST_DIR}"

        # Run QUAST
        quast.py \
            "${contigs}" \
            -o "${SAMPLE_QUAST_DIR}" \
            -t 4 \
            --min-contig 500

        echo "QUAST analysis for ${sample} completed."
    fi
done

