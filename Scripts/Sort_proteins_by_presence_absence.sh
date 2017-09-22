#!/bin/bash

SUFFIX=$1

for folder in `ls -d */`; do
	echo $folder

	cd $folder

	mkdir Proteins_Present
	mkdir Proteins_Absent

	for file in `ls $SUFFIX*`; do

		echo $file

		if [ -s $file ]
		then
			echo "$file is present"
			echo mv $file ./Proteins_Present/
		else
			echo "$file is absent"
			echo mv $file ./Proteins_Absent/
		fi
	done

	cd ..
done




