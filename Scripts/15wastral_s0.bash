#!/bin/bash
#
#SBATCH --chdir=/path/raxml/BS       
#SBATCH --job-name=wastral           
#SBATCH --partition=long             
#SBATCH --ntasks=1                   
#SBATCH --cpus-per-task=4            
#SBATCH --mem=24G                    
#SBATCH --mail-user=email@kew.org   
#SBATCH --mail-type=END,FAIL         

# Path to the wASTRAL executable
WASTRAL_EXEC=/path/apps/ASTER-MacOS/bin/wastral

# Run wASTRAL
$WASTRAL_EXEC \
 -o /path/raxml/BS/raxml_allebg_wastral.s0.full.tre \   
 -i /path/raxml/BS/gene-trees_RAxML_allebg.trees \      
 2> raxml.allebg_wastral.s0.log                         
