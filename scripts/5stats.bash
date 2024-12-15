#!/bin/bash
#
# SLURM directives for configuring the job

#SBATCH--chdir=/path/assembly          # Sets the working directory for the job
#SBATCH --job-name=stats               # Names the job "stats"
#SBATCH --partition=long               # Specifies the "long" partition for jobs requiring extended runtime
#SBATCH --ntasks=1                     # Allocates one task for the job
#SBATCH --cpus-per-task=10             # Allocates CPU cores for the task
#SBATCH --mem=24G                      # Allocates memory
#SBATCH --mail-user=email@kew.org  # Email address for job notifications
#SBATCH --mail-type=END,FAIL           # Sends notifications when the job ends or fails

# --- Generate Statistics Using HybPiper ---
# This step computes assembly statistics for the targeted genes using HybPiper.

hybpiper stats \
  -t_aa /path/scripts/Angiosperms353_targetSequences_organism-gene_format_corrected.pep \  # Path to the target amino acid reference sequences
  gene /path/scripts/Apocynaceae_all_uniquenames.txt                                     # Gene type and list of sample names

# Explanation of Key Commands:
# - `hybpiper stats`: A HybPiper command to generate assembly statistics for targeted genes.
# - `-t_aa`: Specifies the reference target sequences in amino acid format.
# - `gene`: Indicates that the statistics should be calculated for gene sequences.
# - `/path/scripts/Apocynaceae_all_uniquenames.txt`: Text file containing the list of unique sample names to include in the analysis.
