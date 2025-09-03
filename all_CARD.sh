#!/bin/bash

# Create output folder
mkdir -p CARD

# Run abricate with strict thresholds
for file in fasta/*.fasta; do
    base=$(basename "$file" .fasta)
    abricate --db card  "$file" > CARD/"$base"_card.tsv
done

# Create summary file
abricate --summary CARD/*.tsv > abricate_card_summary.tsv
