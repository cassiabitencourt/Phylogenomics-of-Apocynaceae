#!/bin/bash

# paths
input_dir="/Users/c.bitencourt/Downloads/alignments_TAXON/7rename_fasta_entries"
output_dir="/Users/c.bitencourt/Downloads/trees_TAXON/RAxML-NG_AICc"
model_file="/Users/c.bitencourt/Downloads/trees_TAXON/IQTree_models/AICc/All_models_4_models.txt"
RAxMLNG_EXEC=/Users/c.bitencourt/raxml-ng_v2-3/raxml-ng                                    

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


	$RAxMLNG_EXEC \
 	--adaptive \
 	--msa "$file" \
 	--model "$current_model" \
 	--prefix "$output_dir/$name" \
 	--threads auto 
done

exec 3<&-
