#!/bin/bash
#
#SBATCH --chdir=/path/raxml               # Change working directory to /path/raxml
#SBATCH --job-name=RAxMLadaptive          # Set job name to "RAxMLadaptive"
#SBATCH --partition=long                  # Use the 'long' partition for longer jobs
#SBATCH --array=1-183                     # Job array from 1 to 183 (one job per gene)
#SBATCH --ntasks=4                        # Assign tasks per job
#SBATCH --cpus-per-task=4                 # Allocate CPUs per task for parallel processing
#SBATCH --mem=2G                          # Allocate memory per job
#SBATCH --mail-user=email@kew.org         # Send notifications to this email
#SBATCH --mail-type=END,FAIL              # Send notifications when job ends or fails


# Print the task ID for tracking purposes
echo "SLURM_ARRAY_TASK_ID: $SLURM_ARRAY_TASK_ID"

# Extract the gene name from Gene_names.txt
name=$(awk -v lineid=$SLURM_ARRAY_TASK_ID 'NR==lineid{print;exit}' /home/cbitenco/scratch/private/Projects/Apocys/PAFTOL_1KP_NIF-CB/raxml_uniques/All_models_4_names.txt)
echo "Using gene name: $name"

# Extract the model from All_models_4_models.txt
model=$(awk -v lineid=$SLURM_ARRAY_TASK_ID 'NR==lineid{print;exit}' /home/cbitenco/scratch/private/Projects/Apocys/PAFTOL_1KP_NIF-CB/raxml_uniques/All_models_4_models.txt)
echo "Using model: $model"

# Path to RAxML adaptive binary
RAxMLadaptive_EXEC=/home/cbitenco/scratch/apps/raxml-ng/bin/raxml-ng-adaptive

# Ensure both variables are not empty before running RAxML-NG
if [[ -z "$name" || -z "$model" ]]; then
    echo "Error: Gene name or model is empty. Please check the input files."
    exit 1
fi

# Ensure the input file exists
msa_file="${name}_taper_r_cT.fasta"
if [[ ! -f "$msa_file" ]]; then
    echo "Error: Alignment file not found: $msa_file"
    exit 1
fi

# Run RAxML-NG adaptive with the selected gene and model
$RAxMLadaptive_EXEC \
 --adaptive \                          # Use adaptive sampling for model selection
 --msa "$msa_file" \                   # Specify the MSA file
 --model "$model" \                    # Specify the substitution model
 --prefix "$name"                      # Set output file prefix based on gene name
