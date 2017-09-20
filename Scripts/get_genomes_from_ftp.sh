#!/bin/bash


#provided you have a file in directory DIR with ftp address pointing to a genome in the ncbi ftp server,
#this script should download all the genomes and store them in that folder

DIR=$1
NSKIP=$2

cd $DIR

echo "in $DIR"

while read genomes; do

wget -r -nH --cut-dirs=$2 $genomes;

done <$3
