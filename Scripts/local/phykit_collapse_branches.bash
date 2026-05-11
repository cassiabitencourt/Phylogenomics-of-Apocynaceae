#!/bin/bash       

# paths
input_dir="/Users/c.bitencourt/Downloads/trees_TAXON/EBG_AICc"
output_dir="/Users/c.bitencourt/Downloads/trees_TAXON/EBG_collapsed_AICc"

# create output
mkdir -p "$output_dir"

# loop through each alignment
for file in "$input_dir"/*.ebg_median_support_prediction.newick; do
	# names
 	name=$(basename "$file")
 	
 	echo "Processing: $name"

# Run CIAlign
phykit collapse_branches "$file" -s 50 -o "$output_dir/$name"
done
