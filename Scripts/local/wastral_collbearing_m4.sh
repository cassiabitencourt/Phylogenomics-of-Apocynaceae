#!/bin/bash                                  

base="/path/to/trees/EBG_collapsed"
name="$base/Apocynaceae.bearing.genes.txt"
trees="$base/gene-trees_Apocynaceae_collbearing_AICc_RAxMLebg.trees"

>"$trees"

while read -r line; do
  [[ -z "$line" ]] && continue
  cat "${base}/${line}.ebg_median_support_prediction.newick" >> "$trees"
done < $name

WASTRAL_EXEC="/path/to/ASTER-MacOS/bin/wastral"

$WASTRAL_EXEC --mode 4 -R --support 3 \
-o "$base/Apocynaceae.wastral.full.annotated.collbearing.AICc.m4.tre" \
-i "$trees" \
2> "$base/Apocynaceae.wastral.full.annotated.collbearing.AICc.m4.tre.log"
