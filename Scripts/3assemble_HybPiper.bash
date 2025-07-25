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
# HybPiper generates many temporary files and directories. These are stored in local scratch space ($TMPDIR), which is deleted after the job completes
# Results must be copied to a permanent directory before the job ends to prevent data loss
# Documentation: https://help.cropdiversity.ac.uk/data-storage.html#local-scratch

# Change to the local scratch directory
cd $TMPDIR

# If trimmed read files are compressed, they must be unzipped first. Uncomment the following line if necessary:
# parallel -j12 "gunzip {}" ::: *.fastq.gz

# HybPiper is used to assemble targeted loci for the current sample
hybpiper assemble \
  -t_aa /path/scripts/Angiosperms353_targetSequences_organism-gene_format_corrected.pep \  
  --readfiles /path/trimmed_file/"$name"_R1_Tpaired.fastq.gz /path/trimmed_file/"$name"_R2_Tpaired.fastq.gz \  
  --prefix $name \                       
  --diamond \                            
  --diamond_sensitivity mid-sensitive \ 
  --cov_cutoff 8 \                       
  --run_intronerate \                   
  --cpu ${SLURM_CPUS_PER_TASK}           

# At this stage, HybPiper creates a folder for each sample, with subfolders containing concatenated exon sequences for each gene

# Copy folders and files from the local scratch directory to the permanent directory to avoid data loss
parallel 'cp -r {} /path/assembly/' ::: *  
#parallel 'cp {} /path/assembly/' ::: *   