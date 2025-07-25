#!/bin/bash
#
#SBATCH --chdir=/path/mafft/CIalign            
#SBATCH --job-name=taper                       
#SBATCH --partition=medium                    
#SBATCH --array=1-353%20                       
#SBATCH --ntasks=1                             
#SBATCH --cpus-per-task=20                     
#SBATCH --mem=2G                               
#SBATCH --mail-user=email@kew.org              
#SBATCH --mail-type=END,FAIL                   

echo $SLURM_ARRAY_TASK_ID                      

# Extracts the gene name from the file Gene_names.txt corresponding to the current task ID
name=$(awk -v lineid=$SLURM_ARRAY_TASK_ID 'NR==lineid{print;exit}' /path/scripts/Gene_names.txt)

echo $name                                    

# Path to the Julia script for TAPER (a tool for error correction in sequence alignments)
JULIA_EXEC=/path/apps/TAPER/correction_multi.jl

# Runs the TAPER tool on the cleaned CIAlign fasta file using Julia
/path/apps/conda/bin/julia $JULIA_EXEC -m N -a N "$name".CIalign.fasta_cleaned.fasta > "$name"_taper_r_cT.fasta
