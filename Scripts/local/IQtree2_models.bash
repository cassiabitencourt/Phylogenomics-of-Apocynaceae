#!/bin/bash

# paths
input_dir="/Users/c.bitencourt/Downloads/alignments_TAXON/7rename_fasta_entries"
output_dir="/Users/c.bitencourt/Downloads/trees_TAXON/IQTree_models"                                    

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
