#!/bin/bash
#
#SBATCH --chdir=/path/IQtree            
#SBATCH --job-name=iqtree                
#SBATCH --partition=medium               
#SBATCH --array=1-50%10                  
#SBATCH --cpus-per-task=10               
#SBATCH --mem=3G                         
#SBATCH --mail-user=email@kew.org       
#SBATCH --mail-type=END,FAIL             

echo $SLURM_ARRAY_TASK_ID                

# Extract the gene name corresponding to the current array task ID from a list
name=$(awk -v lineid=$SLURM_ARRAY_TASK_ID 'NR==lineid{print;exit}' /path/scripts/Gene_names.txt)

echo $name                               

# Run IQ-TREE with the following options:
iqtree2 \
  -s "$name"_taper_r_cT.fasta.aln        
  -m MFP                                 
  -AICc                                  
  --prefix "$name"                      
  -B 1000                               
  -T AUTO                                
  -redo                                  

# Copy all generated results to the desired directory
parallel 'cp -r {} /path/IQtree/' ::: *   
#parallel 'cp {} /path/IQtree/' ::: *      
