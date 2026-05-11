#!/bin/bash                                  

base="/Users/c.bitencourt/Downloads/trees_TAXON/EBG_collapsed_AICc"
name="$base/Apocynaceae.all.genes.txt"
trees="$base/gene-trees_Apocynaceae_collall_AICc_RAxMLebg.trees"

>"$trees"

while read -r line; do
  [[ -z "$line" ]] && continue
  cat "${base}/${line}.ebg_median_support_prediction.newick" >> "$trees"
done < $name

WASTRAL_EXEC="/Users/c.bitencourt/ASTER-MacOS/bin/wastral"

$WASTRAL_EXEC --mode 4 -R --support 3 \
-o "$base/Apocynaceae.wastral.full.annotated.collall.AICc.m4.tre" \
-i "$trees" \
2> "$base/Apocynaceae.wastral.full.annotated.collall.AICc.m4.tre.log"
