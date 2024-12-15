#!/bin/bash
# 
# SLURM directives for configuring the job

#SBATCH--chdir=/path/assembly          # Sets the working directory for the job
#SBATCH --job-name=recoverygenes       # Sets the name of the job as "recovery genes"
#SBATCH --partition=long               # Specifies the "long" partition for extended runtime jobs
#SBATCH --ntasks=1                     # Allocates one task for the job
#SBATCH --cpus-per-task=8              # Allocates CPU cores for the task
#SBATCH --mem=24G                      # Allocates memory
#SBATCH --mail-user=email@kew.org      # Email address for job notifications
#SBATCH --mail-type=END,FAIL           # Sends notifications when the job ends or fails

# --- Retrieve Gene FASTA Files with HybPiper ---
# This step uses HybPiper to extract assembled gene sequences in FASTA format for downstream analyses.

hybpiper retrieve_sequences dna \                       # Specifies the "dna" retrieval mode to get DNA sequences
  --targetfile_dna /path/scripts/Angiosperms353_targetSequences_organism-gene_format_corrected.fasta \  # Input file containing target DNA sequences
  --sample_names /path/scripts/Apocynaceae_all_uniquenames.txt \  # Text file listing all sample names
  --fasta_dir /path/scripts/Gene_files \               # Output directory for the retrieved gene FASTA files
  --stats_file /path/assembly/hybpiper_stats.tsv \     # Output file for statistical summary of the gene recovery process
  --filter_by GenesAt25pct "greater" 0.50              # Filter to include only genes with greater than 50% recovery in at least 25% of samples

# Explanation of parameters:
# - `retrieve_sequences`: A HybPiper command to extract sequences for the specified targets (e.g., DNA, protein).
# - `--targetfile_dna`: Path to the reference file containing target gene sequences in DNA format.
# - `--sample_names`: File containing a list of sample names for retrieving sequences.
# - `--fasta_dir`: Directory where retrieved FASTA files will be saved. Each gene will have its own FASTA file.
# - `--stats_file`: Generates a summary file containing recovery statistics for each gene and sample.
# - `--filter_by GenesAt25pct "greater" 0.50`: Filters genes to include only those with recovery greater than 50% in at least 25% of samples.
