#!/bin/bash
#
#SBATCH --partition=long

for file in *.FNA; do
    mv "$file" "${file%.FNA}.fasta"
done