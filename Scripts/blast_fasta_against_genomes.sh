#!/bin/bash


FASTA_TARBALL=$1

GENOMES_ROOT=$2

cd $GENOMES_ROOT

echo $CWD

tar -xzf $FASTA_TARBALL

for fasta in `ls *.fasta`; do

	echo "Processing $fasta"
	
	for folder in `ls -d */`; do

		echo $folder
		cd $folder
		DB=`ls *.faa.gz`#need to change this to match what is in the genome folders
		blastp -query $fasta -db ${DB%.faa.gz} -outfmt 6 -max_target $3 --output #add output to match the query name
		cd ..
	done

done


#for folder in `ls -d */`; do

#	query=`ls $PWD/*.fasta`
#echo $folder
#echo $query
#cd $folder
#DB=`ls *.faa`
#blastp -query $query -db $DB -outfmt 6 -max_target_seqs 10
#cd ..

#done<$1 

