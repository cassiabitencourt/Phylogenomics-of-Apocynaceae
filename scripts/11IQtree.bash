#!/bin/bash
#
#SBATCH --chdir=/path/IQtree             # Set the working directory to the specified path
#SBATCH --job-name=iqtree                # Assign a job name for the SLURM job scheduler
#SBATCH --partition=medium               # Specify the partition/queue to run the job
#SBATCH --array=1-50%10                  # Define an array job with 50 tasks, running a maximum of 10 simultaneously
#SBATCH --cpus-per-task=10               # Allocate CPUs per task for parallel processing
#SBATCH --mem=3G                         # Assign memory per task
#SBATCH --mail-user=email@kew.org        # Email address to notify upon job completion or failure
#SBATCH --mail-type=END,FAIL             # Email notifications will be sent when the job ends or fails

echo $SLURM_ARRAY_TASK_ID                # Print the current array task ID to the output log

# Extract the gene name corresponding to the current array task ID from a list
name=$(awk -v lineid=$SLURM_ARRAY_TASK_ID 'NR==lineid{print;exit}' /path/scripts/Gene_names.txt)

echo $name                               # Print the gene name to the output log

# Run IQ-TREE with the following options:
iqtree2 \
  -s "$name"_taper_r_cT.fasta.aln        # Input alignment file for the current gene
  -m MFP                                 # Perform model selection using ModelFinder Plus
  -AICc                                  # Use the corrected Akaike Information Criterion (AICc) for model selection
  --prefix "$name"                       # Set the prefix for output files
  -B 1000                                # Perform 1000 slow standard nonparametric bootstrap replicates for tree support values
  -T AUTO                                # Automatically determine the number of threads to use
  -redo                                  # Overwrite existing output files if they exist

# Copy all generated results to the desired directory
parallel 'cp -r {} /path/IQtree/' ::: *   # Copy all folders back to the specified directory
parallel 'cp {} /path/IQtree/' ::: *      # Copy all files back to the specified directory
