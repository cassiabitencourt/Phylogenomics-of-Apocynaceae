#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=hybpiper-nf
#SBATCH --partition=long
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=32G
#SBATCH --mail-user=email@kew.org
#SBATCH --mail-type=END,FAIL
#SBATCH --output=logs/%x-%j.out
#SBATCH --error=logs/%x-%j.err

set -euo pipefail

# Writable dirs
export APPTAINERENV_CACHEDIR=/home/user/scratch/.singularity
export WORK=/home/user/scratch/nxf-work
export TMPDIR=/home/user/scratch/tmp
mkdir -p "$TMPDIR" "$APPTAINERENV_CACHEDIR" "$WORK"

# Container-visible writable cache dirs (previous version if saving elsewhere on scratch)
export APPTAINERENV_TMPDIR="$TMPDIR"
export APPTAINERENV_MPLCONFIGDIR="$TMPDIR/mpl"
export APPTAINERENV_XDG_CACHE_HOME="$TMPDIR/xdg-cache"
export APPTAINERENV_FONTCONFIG_PATH="$TMPDIR/fontconfig"
export APPTAINERENV_TEMP="$TMPDIR"
export APPTAINERENV_TMP="$TMPDIR"
export APPTAINERENV_TEMPLDIR="$TMPDIR"
mkdir -p "$TMPDIR/mpl" "$TMPDIR/xdg-cache" "$TMPDIR/fontconfig"

# Check disk space before proceeding
df -h /home/user/scratch

nextflow run hybpiper.nf \
  -c hybpiper.config \
  -entry assemble \
  -profile slurm_singularity \
  --targetfile_aa /home/user/apps/hybpiper-nf/Angiosperms353_targetSequences_organism-gene_format_corrected.pep \
  --illumina_reads_directory /home/user/projects/rbgk/projects/cbitencourt/Apocynaceae_all_with_160_163 \
  --outdir /home/user/scratch/private/Apocynaceae_Dec2025_hybpiper-nf \
  --use_trimmomatic true \
  --trimmomatic_min_length 30 \
  --trimmomatic_sliding_window_quality 25 \
  --diamond \
  --diamond_sensitivity ultra-sensitive \
  --exonerate_refine_full \
  --compress_sample_folder \
  --heatmap_filetype png \
  -with-report -with-timeline -with-trace -resume
