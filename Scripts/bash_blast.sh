#!/bin/bash

#need to be in folder where the genomes are

#given a file with a list of proteins to blast.

for read sequence; do

	echo $sequence;

done<$1


#for folder in `ls -d */`; do

#	query=`ls $PWD/*.fasta`
#echo $folder
#echo $query
#cd $folder
#DB=`ls *.faa`
#blastp -query $query -db $DB -outfmt 6 -max_target_seqs 10
#cd ..

#done<$1 

