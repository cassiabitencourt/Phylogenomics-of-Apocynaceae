#!/bin/bash
#
#SBATCH --chdir=/path/raxml               
#SBATCH --job-name=RAxMLadaptive          
#SBATCH --partition=long                  
#SBATCH --array=1-183                     
#SBATCH --ntasks=4                        
#SBATCH --cpus-per-task=4                 
#SBATCH --mem=2G                          
#SBATCH --mail-user=email@kew.org         
#SBATCH --mail-type=END,FAIL              


# Print the task ID for tracking purposes
echo "SLURM_ARRAY_TASK_ID: $SLURM_ARRAY_TASK_ID"

# Extract the gene name from Gene_names.txt
name=$(awk -v lineid=$SLURM_ARRAY_TASK_ID 'NR==lineid{print;exit}' /path/raxml/All_models_4_names.txt)
echo "Using gene name: $name"

# Extract the model from All_models_4_models.txt
model=$(awk -v lineid=$SLURM_ARRAY_TASK_ID 'NR==lineid{print;exit}' /path/raxml/All_models_4_models.txt)
echo "Using model: $model"

# Path to RAxML adaptive binary
RAxMLadaptive_EXEC=/path/apps/raxml-ng/bin/raxml-ng-adaptive

# Run RAxML-NG adaptive with the selected gene and model
$RAxMLadaptive_EXEC \
 --adaptive \                          
 --msa "$msa_file" \                   
 --model "$model" \                    
 --prefix "$name"                      
