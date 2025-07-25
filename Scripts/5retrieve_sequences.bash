#!/bin/bash
# 
#SBATCH--chdir=/path/assembly          
#SBATCH --job-name=recoverygenes       
#SBATCH --partition=long               
#SBATCH --ntasks=1                     
#SBATCH --cpus-per-task=8              
#SBATCH --mem=24G                     
#SBATCH --mail-user=email@kew.org      
#SBATCH --mail-type=END,FAIL           

# This step uses HybPiper to extract assembled gene sequences in FASTA format for downstream analyses

hybpiper retrieve_sequences dna \                       
  --targetfile_dna /path/scripts/Angiosperms353_targetSequences_organism-gene_format_corrected.fasta \  
  --sample_names /path/scripts/Apocynaceae_all_uniquenames.txt \  
  --fasta_dir /path/scripts/Gene_files \               
  --stats_file /path/assembly/hybpiper_stats.tsv \     
  --filter_by GenesAt25pct "greater" 0.50              
