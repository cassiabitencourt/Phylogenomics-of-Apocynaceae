#!/bin/bash
#
#SBATCH --chdir=/path/Apocynaceae_allraw_2024
#SBATCH --job-name=trimmomatic
#SBATCH --partition=himem
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=4  # Match NUM_THREADS
#SBATCH --mem=24G
#SBATCH --mail-user=email@kew.org
#SBATCH --mail-type=END,FAIL

# Define the number of threads to use for Trimmomatic
NUM_THREADS=4  # Adjust this based on the optimal performance observed during testing

# Run Trimmomatic in parallel for each pair of reads
for f in *R1.fastq.gz; do
    java -jar /path/to/trimmomatic-0.38-0/trimmomatic.jar PE \
        -phred33 \
        "$f" "${f/R1.fastq.gz}R2.fastq.gz" \
        "${f/R1.fastq.gz}R1_Tpaired.fastq.gz" "${f/R1.fastq.gz}R1_Tunpaired.fastq.gz" \
        "${f/R1.fastq.gz}R2_Tpaired.fastq.gz" "${f/R1.fastq.gz}R2_Tunpaired.fastq.gz" \
        ILLUMINACLIP:/path/to/trimmomatic-0.38-0/adapters/TruSeq3-PE-2.fa:1:30:6 \
        LEADING:28 TRAILING:28 SLIDINGWINDOW:4:30 MINLEN:36 -threads $NUM_THREADS
done

# Move trimmed files to a directory
mkdir -p /path/Apocynaceae_allraw_2024/trimmed_files
mv *Tpaired.fastq.gz *Tunpaired.fastq.gz /path/Apocynaceae_allraw_2024/trimmed_files

# Use MultiQC to generate a report for all samples after trimming
module load multiqc  # Adjust based on your HPC cluster setup
multiqc /path/Apocynaceae_allraw_2024/trimmed_files

# Look at the FastQC results and decide if further actions are needed
# This part is left to be implemented by you as it depends on your specific requirements
