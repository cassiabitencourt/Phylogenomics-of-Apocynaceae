#!/bin/bash
#
#SBATCH --chdir=/path/raxml/BS             # Set the working directory for the job
#SBATCH --job-name=wastral                 # Name of the job ("wastral")
#SBATCH --partition=long                   # Specify the SLURM partition (queue) to use ("long")
#SBATCH --ntasks=1                         # Number of tasks (1 in this case; suitable for a single-threaded job)
#SBATCH --cpus-per-task=2                  # Number of CPU cores allocated to the task (2 cores)
#SBATCH --mem=8G                           # Memory allocation for the job (8 GB)
#SBATCH --mail-user=email@kew.org          # Email address to notify about job status
#SBATCH --mail-type=END,FAIL               # Send email notifications when the job ends or fails

WASTRAL_EXEC=/path/apps/ASTER-MacOS/bin/wastral
# Defines the path to the WASTRAL executable as a variable for convenience.

$WASTRAL_EXEC --mode 1 -R --support 3 -o /path/raxml/BS/NTraxml_allebg_wastral.full.tre -i /path/raxml/BS/gene-trees_RAxML_allebg.trees 2> NTraxml.allebg_wastral.log
# Executes WASTRAL with the following options:
# --mode 1: Specifies the execution mode (e.g., species tree reconstruction).
# -R: Requests rooted output.
# --support 3: Configures support threshold for the species tree.
# -o /path/raxml/BS/NTraxml_allebg_wastral.full.tre: Specifies the output file for the species tree.
# -i /path/raxml/BS/gene-trees_RAxML_allebg.trees: Inputs the gene trees for analysis.
# 2> NTraxml.allebg_wastral.log: Redirects standard error output to the file "NTraxml.allebg_wastral.log" for logging purposes.