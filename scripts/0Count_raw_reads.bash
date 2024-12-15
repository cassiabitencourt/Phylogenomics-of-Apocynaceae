#!/bin/bash
#
#SBATCH --partition=long

for f in *_R*.fastq.gz; do
   cat "$f" | awk -v fn="$f" -v OFS='\t' 'END{print fn, int(NR/4)}'
done > raw_reads_summary_after_rename.txt