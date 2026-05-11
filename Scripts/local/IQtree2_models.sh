#!/bin/bash

# paths
input_dir="/path/to/alignments/7rename_fasta_entries"
output_dir="/path/to/trees/IQTree_models"                                    

# check dir
mkdir -p "$output_dir"

# loop through each alignment
for file in "$input_dir"/*.aligned.fasta.tp.fasta.renamed.fa; do
	[ -e "$file" ] || continue
	# names
 	name=$(basename "$file" .aligned.fasta.tp.fasta.renamed.fa)
 	
 	echo "Processing: $name"

# iqtree2
iqtree2 -s "$file" -m MF --prefix "$output_dir/${name}" -T auto
done

# --redo-tree Restore ModelFinder and only redo tree search if needed
# default -T is 1, remember to keep -T auto for better speed (10 cores on my MPro)
# with the P in -m it will build the tree (=slower; it means Model Finder Plus) 
#iqtree2 -s "$file" -m MFP --prefix "$output_dir/${name}" 
