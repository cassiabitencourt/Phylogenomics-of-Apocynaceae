#!/bin/bash

# paths
input_dir="/Users/c.bitencourt/Downloads/alignments_TAXON/7rename_fasta_entries"
output_dir="/Users/c.bitencourt/Downloads/trees_TAXON/RAxML-NG_AICc"
RAxMLNG_EXEC=/Users/c.bitencourt/raxml-ng_v2-3/raxml-ng           
EBG_EXEC=/Users/c.bitencourt/miniforge3/bin/ebg                          

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
              -o "/Users/c.bitencourt/Downloads/trees_TAXON/EBG_AICc/$name.ebg" \
              -raxmlng "$RAxMLNG_EXEC"
done
