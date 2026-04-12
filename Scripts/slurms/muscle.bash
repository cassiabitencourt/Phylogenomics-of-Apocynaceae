#!/bin/bash
#
#SBATCH --chdir=./
#SBATCH --job-name=muscle
#SBATCH --partition=long
#SBATCH --array=1-353%10
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=7G
#SBATCH --mail-user=email@kew.org
#SBATCH --mail-type=END,FAIL

# Print the SLURM array task ID for debugging purposes
echo $SLURM_ARRAY_TASK_ID

# Extract the gene name corresponding to the current task index from the Gene.txt file
name=$(awk -v lineid=$SLURM_ARRAY_TASK_ID 'NR==lineid{print;exit}' /path/to/Genes.txt)

# Print the gene name
echo $name

# Align
muscle -super5 /path/to/07_sequences_dna/"$name".fasta.renamed.fa -output /path/to/2muscle/"$name".aligned.fasta

