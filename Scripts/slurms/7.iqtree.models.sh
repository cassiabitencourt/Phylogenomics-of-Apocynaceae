#!/bin/bash
#
#SBATCH --chdir=/home/user/scratch/private/running/trees
#SBATCH --job-name=iqtree_models
#SBATCH --partition=long
#SBATCH --cpus-per-task=10
#SBATCH --mem=5G
#SBATCH --mail-user=email@kew.org
#SBATCH --mail-type=END,FAIL

input_dir="/home/user/scratch/private/running/alignments/6optrimal_final"
output_dir="/home/user/scratch/private/running/trees/iqtree_models"

# check dir
mkdir -p "$output_dir"

# loop through each alignment
for file in "$input_dir"/*.taper.fasta; do
        [ -e "$file" ] || continue
        # names
        name=$(basename "$file" .taper.fasta)

        echo "Processing: $name"

# iqtree2
iqtree2 -s "$file" -m MF --prefix "$output_dir/${name}" -T auto
done
