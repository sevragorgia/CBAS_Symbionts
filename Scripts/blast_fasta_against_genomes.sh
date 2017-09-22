#!/bin/bash


FASTA_TARBALL=$1

GENOMES_ROOT=$2

cd $GENOMES_ROOT

echo $CWD

tar -xzf $FASTA_TARBALL

for folder in `ls -d */`; do

	echo $folder
	cd $folder

	DB=`ls *.faa.gz`

	for fasta in `ls ../*.fasta`; do

		echo "Processing $fasta"
		
		OUTPUT_NAME=`basename $fasta .fasta`
		echo blastp -query $fasta -db ${DB%.*} -outfmt 6 -max_target_seqs $3 -evalue $4 -out $OUTPUT_NAME
		blastp -query $fasta -db ${DB%.*} -outfmt 6 -max_target_seqs $3 -evalue $4 -out $OUTPUT_NAME 
	done

	cd ..

done



