#!/bin/bash       

# paths
input_dir="/path/to/trees/EBG"
output_dir="/path/to/trees/EBG_collapsed"

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
