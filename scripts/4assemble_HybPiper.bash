#!/bin/bash
#
#SBATCH--chdir=/path/assembly
#SBATCH --job-name=assemble
#SBATCH --partition=long
#SBATCH --array=1-353%10   
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=28G
#SBATCH --mail-user=email@kew.org
#SBATCH --mail-type=END,FAIL

# Output the current task ID from the job array
echo $SLURM_ARRAY_TASK_ID

# Extract the sample name for the current task
name=$(awk -v lineid=$SLURM_ARRAY_TASK_ID 'NR==lineid{print;exit}' /path/scripts/Apocynaceae_all_uniquenames.txt)

# Print the sample name to verify correctness
echo $name

# Notes about temporary storage:
# HybPiper generates many temporary files and directories. These are stored in local scratch space ($TMPDIR), which is deleted after the job completes.
# Results must be copied to a permanent directory before the job ends to prevent data loss.
# Documentation: https://help.cropdiversity.ac.uk/data-storage.html#local-scratch

# Change to the local scratch directory
cd $TMPDIR

# --- Optional Step: Unzipping Files ---
# If trimmed read files are compressed, they need to be unzipped first. Uncomment the following line if necessary:
# parallel -j12 "gunzip {}" ::: *.fastq.gz

# --- Run HybPiper ---
# HybPiper is used to assemble targeted loci for the current sample.
hybpiper assemble \
  -t_aa /path/scripts/Angiosperms353_targetSequences_organism-gene_format_corrected.pep \  # Input target sequences in protein format
  --readfiles /path/trimmed_file/"$name"_R1_Tpaired.fastq.gz /path/trimmed_file/"$name"_R2_Tpaired.fastq.gz \  # Input paired-end reads for the sample
  --prefix $name \                       # Prefix for output files, using the sample name
  --diamond \                            # Use DIAMOND aligner for protein-level alignment
  --diamond_sensitivity mid-sensitive \  # Sets the alignment sensitivity level
  --cov_cutoff 8 \                       # Minimum coverage threshold for including loci
  --run_intronerate \                    # Run Intronerate to identify intron-exon boundaries
  --cpu ${SLURM_CPUS_PER_TASK}           # Allocates CPU resources based on the SLURM configuration

# At this stage, HybPiper creates a folder for each sample, with subfolders containing concatenated exon sequences for each gene.

# --- Copy Results Back ---
# Copy folders and files from the local scratch directory to the permanent directory to avoid data loss
parallel 'cp -r {} /path/assembly/' ::: *  # Copy all folders
parallel 'cp {} /path/assembly/' ::: *    # Copy all files