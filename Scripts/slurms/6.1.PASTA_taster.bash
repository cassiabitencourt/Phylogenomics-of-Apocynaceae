#!/bin/bash
#SBATCH --job-name=optrimal
#SBATCH --partition=long
#SBATCH --mail-user=c.bitencourt@kew.org
#SBATCH --mail-type=END,FAIL

# PASTA_taster.sh - run this first
# This script tests if the pasta is gluten-free.
# JK. This is a wrapper around optrimAl that generates trimmed alignments using trimAl 1.2 (Capella-Gutierrez et al, 2009) at successively stricter trimming thresholds then summarises statistics for these trimmed alignments using AMAS (Borowiec, 2016).
# It calls the optrimAl script, which then returns all alignment files trimmed to an optimum threshold defined as yielding the maximum proportion of parsimony informative characters but losing no more data than one median absolute deviation above the median data loss across the entire range of trimming thresholds being tested.
# Alignments that lose more than a set cap of data (default 30% in the script) after optimal trimming are not returned.
# Theoretically, I prefer this approach because it considers the amount of missing data in each data set and avoids excessive trimming, instead of setting an arbitrary fixed gap threshold, which DOES result in loss of informativeness in some data sets.
# Empirically, this approach has NOT been tested.
# If you find any bugs, please modify accordingly and let me know (totally optional). I will probably not have any time to troubleshoot in the near future (maybe when I'm finally retired). Good luck! ZQ

# This script produces ALOT of output.
# Alignment files (e.g. *.aln) returned to the working directory are the optimally trimmed alignments.
# overlost.txt lists the alignments where data loss exceeded the cap.
# dldp*.png are graphs showing the proportion of parsimony informative characters and data loss at each trimming threshold, as well as the selected trimming threshold, for each alignment.
# dldp*.csv are the raw data from which the graphs are produced.
# summary*.txt are the summary statistics produced by AMAS.
# Directories named with the specified trimming threshold values (e.g. 0.1) should be deleted immediately once done with analysis as they take up ALOT of space.

# Provide a text file with desired trimming threshold values, one per line (cutoff_trim.txt).
# Make sure to set the working directory and trimAl path correctly, that optrimal.R and cutoff_trim.txt are in the same directory, update the file name pattern for the alignment where required and provide a set of trimming thresholds (any number of thresholds from 0 to 1, one threshold per line, must include 0 and 1) in the cutoff_trim.txt input file.
# My working directory in this case was ‘~/zq/working/optrimal’, my trimAl path was ‘~/zq/bin/trimAl/source/trimal’ and my file name pattern was 'g*' so just change those accordingly.
# This script WILL generate non-fatal errors where alignments are missing - check if these alignments were intentionally omitted or went missing for some other reason.

cd /home/cbitenco/scratch/private/running/alignments/2muscle || exit

while read -r cutoff_trim || [[ -n "$cutoff_trim" ]]; do
    [[ -z "$cutoff_trim" ]] && continue

    echo "Processing cutoff: $cutoff_trim"
    mkdir -p "$cutoff_trim"

    for alignment in *.aligned.fasta; do
        output_file="${cutoff_trim}/${alignment}.aln"
        html_file="${cutoff_trim}/${alignment}.htm"

        # trimAL
        /mnt/apps/users/cbitenco/conda/bin/trimal \
          -in ${alignment} \
          -out "$output_file" \
          -htmlout "$html_file" \
          -gt "$cutoff_trim"

        # check if the alignment was trimmed to extinction by trimAl
        if grep -q "0 bp" "$html_file" 2>/dev/null; then
            echo "Removing $output_file"
            rm -f "$output_file"
        fi
    done

# AMAS on trimmed files
(
    cd "${cutoff_trim}" || exit
    if ls *.aln >/dev/null 2>&1; then
        python3 /home/cbitenco/apps/conda/bin/AMAS.py summary \
            -f fasta -d dna -i *.aln
        mv summary.txt "summary_${cutoff_trim}.txt"
    fi
)
done < /home/cbitenco/scratch/private/running/alignments/2muscle/cutoff_trim.txt

#Rscript ../optrimal.R "summary_${cutoff_trim}.txt"
