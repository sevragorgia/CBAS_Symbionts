#!/bin/bash


echo "Protein	Present_in	Annotation"

for file in `ls *.fasta`; do

	COUNT=0

	protein_annotation=`grep ">" $file`

	filename=`basename $file .fasta`

	for folder in `ls -d */`; do
	
		cd $folder

		if [ -s $filename ]
		then
			COUNT=$((COUNT+1))
		fi

		cd ..
	done

	echo "$file	$COUNT	$protein_annotation"

done





