#!/bin/bash
#SBATCH --chdir=/path/to/rawdata
#SBATCH --job-name=fastqc
#SBATCH --partition=long
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --export=ALL
#SBATCH --mail-user=email@kew.org
#SBATCH --mail-type=END,FAIL

# run FastQC
for f in *.fastq.gz; 
do (fastqc $f); 
done
# loops through all files ending with `.fastq.gz` in the working directory

# create a new directory to store all outputs
mkdir /path/to/rawdata/fastqc_pre_trim_all

# Move FastQC outputs to the new directory
mv *.zip /path/to/rawdata/fastqc_pre_trim_all
mv *.html /path/to/rawdata/fastqc_pre_trim_all

# Use MultiQC to aggregate and summarise FastQC reports
multiqc ./
