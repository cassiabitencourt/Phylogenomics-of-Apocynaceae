#!/bin/bash
#
# We retained hard-to-analyze genes, using 'analyze' with a 'z' to match the spelling in the RAxML output log file
# List the files and save the names to hard-to-analyze.txt
ls raxml_*.raxml.log > hard-to-analyze.txt

# Clear genes.txt to ensure it's empty at the start
> genes.txt

# For each file listed in hard-to-analyze.txt
while read f; do
    if grep -q "hard-to-analyze" "$f"; then
        hard_to_analyze_line=$(grep "hard-to-analyze" "$f")
        alignment_line=$(grep "Reading alignment from file: .*\.fasta" "$f" | head -n 1)
        
        # Combine both lines into a single line
        echo -e "${hard_to_analyze_line}\t${alignment_line}" >> genes.txt
    else
        # Add an empty line if "hard-to-analyze" is not found
        echo -e "" >> genes.txt
    fi
done < hard-to-analyze.txt

# Combine the file names with the output in genes.txt
paste -d "\t" hard-to-analyze.txt genes.txt > All_genes.txt

# Remove the intermediate files
rm hard-to-analyze.txt genes.txt
