#!/bin/bash

ls *.raxml.log > file_names.txt
while read f; do grep "Partition #0: " $f; done < file_names.txt >> models.txt
paste -d "\t" file_names.txt models.txt > All_models.txt
rm -rf file_names.txt models.txt

sed -e 's/.raxml.log//g' \
    -e 's/Partition #0: //g' \
    -e 's/ Partition #0: //g' All_models.txt > All_models_2.txt
    
sed -e 's/([^)]*)//g' All_models_2.txt > All_models_3.txt

cut -f2 All_models_3.txt > All_models_4_models.txt
cut -f1 All_models_3.txt > All_models_4_names.txt
