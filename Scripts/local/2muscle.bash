#!/bin/bash
#
#SBATCH --chdir=./
#SBATCH --job-name=muscle
#SBATCH --partition=medium
#SBATCH --array=1-353%10
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=7G
#SBATCH --mail-user=c.bitencourt@kew.org
#SBATCH --mail-type=END,FAIL

# Print the SLURM array task ID for debugging purposes
echo $SLURM_ARRAY_TASK_ID

# Extract the gene name corresponding to the current task index from the Gene.txt file
name=$(awk -v lineid=$SLURM_ARRAY_TASK_ID 'NR==lineid{print;exit}' /home/cbitenco/scratch/private/running/alignments/1original-hybpiper-nf/Genes.txt)

# Print the gene name
echo $name

# Align
muscle -super5 /home/cbitenco/scratch/private/running/alignments/1original-hybpiper-nf/"$name".fasta.renamed.fa -output /home/cbitenco/scratch/private/running/alignments/2muscle/"$name".aligned.fasta

