#!/bin/bash
#
#SBATCH --chdir=/path/raxml/BS         # Change directory to the specified path where the bootstrap results will be stored
#SBATCH --job-name=EBG                # Set the job name to 'EBG'
#SBATCH --partition=himem            # Use the 'himem' partition for high-memory tasks
#SBATCH --array=1-183                # Run as an array job, with 183 tasks
#SBATCH --ntasks=2                   # Request 2 tasks
#SBATCH --cpus-per-task=2            # Allocate 2 CPUs per task
#SBATCH --mem=4G                     # Allocate 4GB of memory per task
#SBATCH --mail-user=email@kew.org    # Specify the email address to send notifications
#SBATCH --mail-type=END,FAIL         # Send notifications when the job ends or fails

# Output the task ID for reference
echo $SLURM_ARRAY_TASK_ID

# Extract the gene name corresponding to the current task ID from 'All_models_4_names.txt'
name=$(awk -v lineid=$SLURM_ARRAY_TASK_ID 'NR==lineid{print;exit}' /path/raxml/All_models_4_names.txt)
echo $name

# Extract the model corresponding to the current task ID from 'All_models_4_models.txt'
model=$(awk -v lineid=$SLURM_ARRAY_TASK_ID 'NR==lineid{print;exit}' /path/raxml/All_models_4_models.txt)
echo $model

# Set the path to the EBG tool and RAxML-NG binary
EBG_EXEC=/path/apps/conda/bin/ebg           # Path to the EBG executable
raxmlng_EXEC=/path/apps/raxml-ng-dev/bin/raxml-ng   # Path to the RAxML-NG executable

# Run the EBG tool for bootstrap analysis, providing input files and output locations
$EBG_EXEC -msa /path/raxml/"$name"_taper_r_cT.fasta \       # Input multiple sequence alignment (MSA) file
          -tree /path/raxml/raxml_"$name".raxml.bestTree \   # Input tree file with the best tree from RAxML
          -model /path/raxml/raxml_"$name".raxml.bestModel \ # Input the best model file for RAxML
          -t b \                                           # Bootstrap type (nonparametric Felsenstein bootstrap)
          -o /path/raxml/BS/"$name"_ebg \                    # Output directory for bootstrap results
          -redo \                                           # Option to overwrite existing output
          -raxmlng $raxmlng_EXEC                            # Specify the path to the RAxML-NG executable
