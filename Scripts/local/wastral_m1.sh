#!/bin/bash                                  

base="/path/to/trees/EBG"
name="$base/Apocynaceae.all.genes.txt"
trees="$base/gene-trees_Apocynaceae_all_AICc_RAxMLebg.trees"

>"$trees"

while read -r line; do
  [[ -z "$line" ]] && continue
  cat "${base}/${line}.ebg_median_support_prediction.newick" >> "$trees"
done < $name

WASTRAL_EXEC="/path/ASTER-MacOS/bin/wastral"

$WASTRAL_EXEC --mode 1 -R --support 3 \
-o "$base/Apocynaceae.wastral.full.annotated.all_AICc.m1.tre" \
-i "$trees" \
2> "$base/Apocynaceae.wastral.full.annotated.all_AICc.m1.tre.log"
