#!/bin/bash

# paths
input_dir="/path/to/alignments/7rename_fasta_entries"
output_dir="/path/to/trees/RAxML-NG"
model_file="/path/to/trees/IQTree_models/AICc/All_models_4_models.txt"
RAxMLNG_EXEC=/path/to/raxml-ng_v2-3/raxml-ng                                    

mkdir -p "$output_dir"

exec 3< "$model_file"

# loop through each alignment
for file in "$input_dir"/*.aligned.fasta.tp.fasta.renamed.fa; do
	[ -e "$file" ] || continue
	
	if ! read -u 3 current_model; then
		echo "Finished"
		break
	fi
	
	# names
 	name=$(basename "$file" .aligned.fasta.tp.fasta.renamed.fa)
 	
 	echo "Processing: $name with $current_model"

# the adaptive run
	$RAxMLNG_EXEC \
 	--adaptive \
 	--msa "$file" \
 	--model "$current_model" \
 	--prefix "$output_dir/$name" \
 	--threads auto 
done

exec 3<&-
