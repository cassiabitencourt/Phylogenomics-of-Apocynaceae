#!/bin/bash
#
#SBATCH --chdir=/path/mafft/CIalign            # Sets the working directory to where the input files are located
#SBATCH --job-name=taper                       # Assigns the job name as "taper"
#SBATCH --partition=medium                     # Specifies the job will run on the "medium" partition
#SBATCH --array=1-353%20                       # Creates an array job to process 1 to 353 files, with 20 jobs running in parallel at once
#SBATCH --ntasks=1                             # Allocates task per job
#SBATCH --cpus-per-task=20                     # Allocates CPU cores per task to speed up the processing
#SBATCH --mem=2G                               # Allocates memory for the job
#SBATCH --mail-user=email@kew.org              # Specifies the email to receive notifications about job status
#SBATCH --mail-type=END,FAIL                   # Sends email notifications when the job finishes or fails

echo $SLURM_ARRAY_TASK_ID                      # Outputs the job array task ID to track which file is being processed

# Extracts the gene name from the file Gene_names.txt corresponding to the current task ID
name=$(awk -v lineid=$SLURM_ARRAY_TASK_ID 'NR==lineid{print;exit}' /path/scripts/Gene_names.txt)

echo $name                                    # Outputs the name of the gene being processed

# Path to the Julia script for TAPER (a tool for error correction in sequence alignments)
JULIA_EXEC=/path/apps/TAPER/correction_multi.jl

# Runs the TAPER tool on the cleaned CIAlign fasta file using Julia
# The command applies multiple corrections and outputs the corrected sequence to a new fasta file
/path/apps/conda/bin/julia $JULIA_EXEC -m N -a N "$name".CIalign.fasta_cleaned.fasta > "$name"_taper_r_cT.fasta
