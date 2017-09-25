#!/bin/bash

SUFFIX=$1

echo "Genome	Protein	Presence/Absence"

for folder in `ls -d */`; do
	#echo $folder

	cd $folder

	mkdir Proteins_Present
	mkdir Proteins_Absent

	for file in `ls $SUFFIX*`; do

		#echo $file

		if [ -s $file ]
		then
			echo "$folder	$file	Present"
			cp -v $file ./Proteins_Present/
		else
			echo "$folder	$file	Absent"
			cp -v $file ./Proteins_Absent/
		fi
	done

	cd ..
done




