#!/bin/bash
WARNING="Predicted difficulty:"
WARNING2="This dataset is considered hard-to-analyze"

> All.noise.gene.scores.tsv
> All.bearing.gene.scores.tsv

ls *.raxml.log | while read f; do
    	# signal-based stats
		score=$(grep "$WARNING" "$f" | awk '{print $NF}')
		
		if grep -q "$WARNING2" "$f"; then
		echo -e "$f\t$score" >> All.noise.gene.scores.tsv
	else 
		echo -e "$f\t$score" >> All.bearing.gene.scores.tsv
	fi
done
# >> in case it is not necessary to replace the file when including new metrics
