#!/bin/bash
#
#SBATCH --chdir=/path/Gene_files           # Changes the working directory to the folder containing gene files
#SBATCH --job-name=mafft                   # Assigns the job name as 'mafft' to track the task
#SBATCH --partition=medium                 # Specifies the job will run in the 'medium' partition of the cluster
#SBATCH --array=1-353%10                   # Array job configuration: processes 353 tasks, with 10 jobs running concurrently
#SBATCH --ntasks=1                         # Allocates one task per job (since we are processing one file at a time)
#SBATCH --cpus-per-task=10                 # Allocates CPU cores for each job to speed up the alignment process
#SBATCH --mem=7G                           # Allocates memory for each job to handle the sequence alignment
#SBATCH --mail-user=email@kew.org          # Specifies the email address for notifications about job status
#SBATCH --mail-type=END,FAIL               # Sends email notifications when the job finishes or fails

# Print the SLURM array task ID for debugging purposes
echo $SLURM_ARRAY_TASK_ID

# Extract the gene name corresponding to the current task index from the Gene_names.txt file
name=$(awk -v lineid=$SLURM_ARRAY_TASK_ID 'NR==lineid{print;exit}' /path/scripts/Gene_names.txt)

# Print the gene name for debugging purposes
echo $name

# Perform sequence alignment using MAFFT's linsi algorithm
# Adjusts direction and sets the maximum number of iterations to 1000
linsi --adjustdirectionaccurately --maxiterate 1000 /path/Gene_files/"$name".fasta > /path/mafft/"$name"_alM.fasta

# Output file with aligned sequences will be saved in the '/path/mafft/' directory with the suffix '_alM.fasta'
