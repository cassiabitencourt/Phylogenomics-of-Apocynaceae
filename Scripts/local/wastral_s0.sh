#!/bin/bash                                  

base="/folder/to/EBG_AICc"
name="$base/Apocynaceae.all.genes.txt"
trees="$base/gene-trees_Apocynaceae_all_AICc_RAxMLebg.trees"

>"$trees"

while read -r line; do
  [[ -z "$line" ]] && continue
  cat "${base}/${line}.ebg_median_support_prediction.newick" >> "$trees"
done < $name

WASTRAL_EXEC="/folder/to/ASTER-MacOS/bin/wastral"

$WASTRAL_EXEC \
-o "$base/Apocynaceae.wastral.full.annotated.all.AICc.s0.tre" \
-i "$trees" \
2> "$base/Apocynaceae.wastral.full.annotated.all.AICc.s0.tre.log"