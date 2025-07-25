#!/bin/bash
#
#SBATCH--chdir=/path/assembly          
#SBATCH --job-name=stats               
#SBATCH --partition=long               
#SBATCH --ntasks=1                    
#SBATCH --cpus-per-task=10             
#SBATCH --mem=24G                     
#SBATCH --mail-user=email@kew.org  
#SBATCH --mail-type=END,FAIL           

# This step computes assembly statistics for the targeted genes using HybPiper
hybpiper stats \
  -t_aa /path/scripts/Angiosperms353_targetSequences_organism-gene_format_corrected.pep \  
  gene /path/scripts/Apocynaceae_all_uniquenames.txt                                     

