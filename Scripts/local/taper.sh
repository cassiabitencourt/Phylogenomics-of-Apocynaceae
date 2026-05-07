#!/bin/bash

# paths
input_dir="/path/alignments/CIalign"
output_dir="/path/alignments/TAPER"                                    

# check dir
mkdir -p "$output_dir"

# TAPER path
JULIA_EXEC=/path/TAPER/correction_multi.jl

# loop through each alignment
for file in "$input_dir"/*.fasta_cleaned.fasta; do
	# names
 	name=$(basename "$file" .fasta_cleaned.fasta)
 	
 	echo "Processing: $name"

# TAPER run
julia $JULIA_EXEC -m - -a - "$file" > "$output_dir/${name}.tp.fasta"
done
