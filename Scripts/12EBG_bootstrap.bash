#!/bin/bash
#
#SBATCH --chdir=/path/raxml/BS         
#SBATCH --job-name=EBG                
#SBATCH --partition=himem            
#SBATCH --array=1-183                
#SBATCH --ntasks=2                   
#SBATCH --cpus-per-task=2            
#SBATCH --mem=4G                     
#SBATCH --mail-user=email@kew.org    
#SBATCH --mail-type=END,FAIL         

# Output the task ID for reference
echo $SLURM_ARRAY_TASK_ID

# Extract the gene name corresponding to the current task ID from 'All_models_4_names.txt'
name=$(awk -v lineid=$SLURM_ARRAY_TASK_ID 'NR==lineid{print;exit}' /path/raxml/All_models_4_names.txt)
echo $name

# Extract the model corresponding to the current task ID from 'All_models_4_models.txt'
model=$(awk -v lineid=$SLURM_ARRAY_TASK_ID 'NR==lineid{print;exit}' /path/raxml/All_models_4_models.txt)
echo $model

# Set the path to the EBG tool and RAxML-NG binary
EBG_EXEC=/path/apps/conda/bin/ebg           
raxmlng_EXEC=/path/apps/raxml-ng-dev/bin/raxml-ng  

# Run the EBG tool for bootstrap analysis, providing input files and output locations
$EBG_EXEC -msa /path/raxml/"$name"_taper_r_cT.fasta \       
          -tree /path/raxml/raxml_"$name".raxml.bestTree \   
          -model /path/raxml/raxml_"$name".raxml.bestModel \ 
          -t b \                                           
          -o /path/raxml/BS/"$name"_ebg \                    
          -redo \                                           
          -raxmlng $raxmlng_EXEC                           
