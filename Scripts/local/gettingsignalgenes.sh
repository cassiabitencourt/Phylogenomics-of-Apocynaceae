#!/bin/bash
#SBATCH --chdir=/home/bschindl/scratch/private/Velloziaceae/running/trees/raxml_models_trees # path to raxml folder

WARNING="This dataset is considered hard-to-analyze"

ls *.raxml.log > All.genes.names.txt

while read f; do grep -q "$WARNING" $f; then < All.genes.names.txt >> All.noise.genes.txt
	else
		echo "$f" >> All.signal.genes.txt
	fi
done