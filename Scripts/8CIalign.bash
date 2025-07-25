#!/bin/bash
#
#SBATCH --chdir=/path/mafft/CIalign        
#SBATCH --job-name=CIAlign                 
#SBATCH --partition=long                   
#SBATCH --array=1-353%10                   
#SBATCH --ntasks=1                        
#SBATCH --cpus-per-task=10                 
#SBATCH --mem=3G                           
#SBATCH --mail-user=email@kew.org          
#SBATCH --mail-type=END,FAIL              

# Print the current task ID (useful for debugging and logging).
echo $SLURM_ARRAY_TASK_ID

# Extract the name of the gene file for the current task ID from the Gene_names.txt file.
# 'lineid' corresponds to the task ID, and the script retrieves the matching line.
name=$(awk -v lineid=$SLURM_ARRAY_TASK_ID 'NR==lineid{print;exit}' /path/scripts/Gene_names.txt)

# Print the name of the gene file being processed (useful for logging and debugging).
echo $name

# Run CIAlign with specified options.
CIAlign \
  --infile /path/mafft/CIalign/"$name"_alM.fasta \           
  --outfile_stem /path/mafft/CIalign/"$name".CIalign.fasta \  
  --remove_divergent \                                        
  --remove_divergent_minperc 0.85 \                           
  --retain_str /path/scripts/outgroups.txt \                 
  --plot_input --plot_output --plot_markup                    
