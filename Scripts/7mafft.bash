#!/bin/bash
#
#SBATCH --chdir=/path/Gene_files           
#SBATCH --job-name=mafft                   
#SBATCH --partition=medium                 
#SBATCH --array=1-353%10                   
#SBATCH --ntasks=1                         
#SBATCH --cpus-per-task=10                 
#SBATCH --mem=7G                           
#SBATCH --mail-user=email@kew.org          
#SBATCH --mail-type=END,FAIL               

# Print the SLURM array task ID for debugging purposes
echo $SLURM_ARRAY_TASK_ID

# Extract the gene name corresponding to the current task index from the Gene_names.txt file
name=$(awk -v lineid=$SLURM_ARRAY_TASK_ID 'NR==lineid{print;exit}' /path/scripts/Gene_names.txt)

# Print the gene name for debugging purposes
echo $name

# Align, adjusts direction and sets the maximum number of iterations to 1000
linsi --adjustdirectionaccurately --maxiterate 1000 /path/Gene_files/"$name".fasta > /path/mafft/"$name"_alM.fasta

# Output file with aligned sequences will be saved in the '/path/mafft/' directory with the suffix '_alM.fasta'
