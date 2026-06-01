#!/bin/bash
#
#SBATCH --chdir=./
#SBATCH --job-name=signal-genes-id
#SBATCH --partition=long
#SBATCH --mail-user=email@kew.org
#SBATCH --mail-type=END,FAIL

#place within the RAxML outputs folder /path/to/trees/raxml_models_trees

WARNING="This dataset is considered hard-to-analyze"

ls *.raxml.log > All.genes.names.txt

while read f; do grep -q "$WARNING" $f; then < All.genes.names.txt >> All.noise.genes.txt
	else
		echo "$f" >> All.signal.genes.txt
	fi
done
