#!/bin/bash

# Create output folder
mkdir -p ecoli_vf

# Run abricate with strict thresholds
for file in fasta/*.fasta; do
    base=$(basename "$file" .fasta)
    abricate --db ecoli_vf "$file" > ecoli_vf/"$base"_vfdb.tsv
done

# Create summary file
abricate --summary ecoli_vf/*.tsv > abricate_ecoli_vf_summary.tsv
