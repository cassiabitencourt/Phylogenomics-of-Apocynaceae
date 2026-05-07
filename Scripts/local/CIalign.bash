#!/bin/bash       

# paths
input_dir="/path/alignments/3optrimal"
output_dir="/path/alignments/4CIalign"
#outgroup_file="/path/alignments/outgroups.txt"

# create output
mkdir -p "$output_dir"

# loop through each alignment
for file in "$input_dir"/*.aligned.fasta.fasta; do
	# names
 	name=$(basename "$file" .CI.fasta)
 	
 	echo "Processing: $name"

# Run CIAlign
CIAlign --infile "$file" --outfile_stem "$output_dir/$name" --crop_ends --remove_divergent --remove_divergent_minperc 0.70 --retain Rubiaceae_Colletoecemateae_Rubioideae_Colletoecema_tortistilum_ERR_5033630 --plot_output --plot_markup
done
