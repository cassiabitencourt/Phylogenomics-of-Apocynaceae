#!/bin/bash
# We retained hard-to-analyze genes, using 'analyze' with a 'z' to match the spelling in the RAxML output log file
# List the files and save the names to hard-to-analyze.txt
ls raxml_*.raxml.log > hard-to-analyze.txt

# Clear genes.txt to ensure it's empty at the start
> genes.txt

# For each file listed in hard-to-analyze.txt
while read f; do
    # Check if the file contains "hard-to-analyze"
    if grep -q "hard-to-analyze" "$f"; then
        # Extract the "hard-to-analyze" line(s)
        hard_to_analyze_line=$(grep "hard-to-analyze" "$f")
        
        # Extract "Reading alignment from file" line if it exists
        alignment_line=$(grep "Reading alignment from file: .*\.fasta" "$f" | head -n 1)
        
        # Combine both lines into a single line with a tab delimiter
        echo -e "${hard_to_analyze_line}\t${alignment_line}" >> genes.txt
    else
        # Add an empty line if "hard-to-analyze" is not found
        echo -e "" >> genes.txt
    fi
done < hard-to-analyze.txt

# Combine the file names with the output in genes.txt using a tab delimiter
paste -d "\t" hard-to-analyze.txt genes.txt > All_genes.txt

# Remove the intermediate files
rm hard-to-analyze.txt genes.txt
