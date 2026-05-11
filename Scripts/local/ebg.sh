#!/bin/bash

# paths
input_dir="/path/to/alignments/7rename_fasta_entries"
output_dir="/path/to/trees/RAxML-NG_AICc"
RAxMLNG_EXEC=/path/to/raxml-ng_v2-3/raxml-ng           
EBG_EXEC=/path/to/miniforge3/bin/ebg                          

mkdir -p "$output_dir"

# loop through each alignment
for file in "$input_dir"/*.aligned.fasta.tp.fasta.renamed.fa; do
    # name will be the filename without .aligned.fasta.tp.fasta.renamed.fa
    name=$(basename "$file" .aligned.fasta.tp.fasta.renamed.fa)
    
    echo "Processing: $name"

    # Run EBG
    $EBG_EXEC -msa "$file" \
              -tree "$output_dir/$name.raxml.bestTree" \
              -model "$output_dir/$name.raxml.bestModel" \
              -t b \
              -o "/path/to/trees/EBG/$name.ebg" \
              -raxmlng "$RAxMLNG_EXEC"
done
