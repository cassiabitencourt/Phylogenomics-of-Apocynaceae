#!/bin/bash                                  

base="/Users/c.bitencourt/Downloads/trees_TAXON/EBG_AICc"
name="$base/Apocynaceae.bearing.genes.txt"
trees="$base/gene-trees_Apocynaceae_bearing_AICc_RAxMLebg.trees"

>"$trees"

while read -r line; do
  [[ -z "$line" ]] && continue
  cat "${base}/${line}.ebg_median_support_prediction.newick" >> "$trees"
done < $name

WASTRAL_EXEC="/Users/c.bitencourt/ASTER-MacOS/bin/wastral"

$WASTRAL_EXEC --mode 1 -R --support 3 \
-o "$base/Apocynaceae.wastral.full.annotated.bearing.AICc.m1.tre" \
-i "$trees" \
2> "$base/Apocynaceae.wastral.full.annotated.bearing.AICc.m1.tre.log"
