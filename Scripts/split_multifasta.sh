#!/bin/bash

MULTIFASTA=$1

split -d -l$2 --additional-suffix=.fasta $MULTIFASTA ${MULTIFASTA%.fasta}-


