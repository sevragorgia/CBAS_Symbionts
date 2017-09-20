#!/bin/bash 

TYPE=$1
EXTENSION=$2

for folder in `ls -d */`; do

	echo $folder
	cd $folder

	SEQUENCE_FILE=`ls *$EXTENSION.gz`
	
	echo $SEQUENCE_FILE

	gunzip $SEQUENCE_FILE

	makeblastdb -in ${SEQUENCE_FILE%.*} -dbtype "$TYPE"

	gzip ${SEQUENCE_FILE%.*}

	cd ..

done



