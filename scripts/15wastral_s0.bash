#!/bin/bash

# SBATCH Configuration
#SBATCH --chdir=/path/raxml/BS       # Set the working directory for the job.
#SBATCH --job-name=wastral           # Assign a descriptive job name.
#SBATCH --partition=long             # Use the "long" partition for extended runtime jobs.
#SBATCH --ntasks=1                   # Request a single task for execution.
#SBATCH --cpus-per-task=4            # Allocate 4 CPU cores for this task.
#SBATCH --mem=24G                    # Request 24 GB of memory for the job.
#SBATCH --mail-user=email@kew.org    # Specify the email address for job notifications.
#SBATCH --mail-type=END,FAIL         # Send email alerts when the job ends or fails.

# Path to the wASTRAL executable
WASTRAL_EXEC=/path/apps/ASTER-MacOS/bin/wastral

# Run wASTRAL
$WASTRAL_EXEC \
 -o /path/raxml/BS/raxml_allebg_wastral.s0.full.tre \   # Output species tree file.
 -i /path/raxml/BS/gene-trees_RAxML_allebg.trees \      # Input gene trees for species tree estimation.
 2> raxml.allebg_wastral.s0.log                         # Redirect error log to a file.
