#!/bin/bash

# Output directory
OUTPUT_DIR="./trimmed"
mkdir -p "${OUTPUT_DIR}"

# Loop through each R1 file in the current directory
for r1 in ./*_R1.fastq.gz
do
    # Get the base name of the R1 file
    base=$(basename "${r1}" _R1.fastq.gz)
    
    # Check if corresponding R2 file exists
    r2="./${base}_R2.fastq.gz"
    if [ ! -e "${r2}" ]; then
        echo "Error: Missing corresponding R2 file for ${r1}"
        continue
    fi
    
    # Define output file names
    out_r1="${OUTPUT_DIR}/${base}_R1_trimmed.fastq.gz"
    out_r2="${OUTPUT_DIR}/${base}_R2_trimmed.fastq.gz"
    html_report="${OUTPUT_DIR}/${base}_fastp.html"
    json_report="${OUTPUT_DIR}/${base}_fastp.json"

    # Run fastp with optimized parameters for paired-end data
    fastp \
        -i "${r1}" \
        -I "${r2}" \
        -o "${out_r1}" \
        -O "${out_r2}" \
        --detect_adapter_for_pe \
        --trim_front1 10 \
        --trim_tail1 10 \
        --trim_front2 10 \
        --trim_tail2 10 \
        --cut_front \
        --cut_tail \
        --cut_window_size 4 \
        --cut_mean_quality 20 \
        --qualified_quality_phred 20 \
        --unqualified_percent_limit 20 \
        --n_base_limit 5 \
        --length_required 50 \
        --low_complexity_filter \
        --thread 4 \
        --html "${html_report}" \
        --json "${json_report}"
done

