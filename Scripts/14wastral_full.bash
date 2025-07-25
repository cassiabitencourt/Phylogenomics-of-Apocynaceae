#!/bin/bash
#
#SBATCH --chdir=/path/raxml/BS             
#SBATCH --job-name=wastral                 
#SBATCH --partition=long                   
#SBATCH --ntasks=1                         
#SBATCH --cpus-per-task=2                  
#SBATCH --mem=8G                           
#SBATCH --mail-user=email@kew.org          
#SBATCH --mail-type=END,FAIL             

WASTRAL_EXEC=/path/apps/ASTER-MacOS/bin/wastral

$WASTRAL_EXEC --mode 1 -R --support 3 -o /path/raxml/BS/NTraxml_allebg_wastral.full.tre /
-i /path/raxml/BS/gene-trees_RAxML_allebg.trees 2> NTraxml.allebg_wastral.log
