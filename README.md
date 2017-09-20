# CBAS Symbiont resources

This repository provides a number of scripts to work with bacterial genomes deposited in the NCBI ftp server and a number of scripts I use to compare these genomes against the genomes of CBAS Symbionts.

NOTE:

most of these scripts are bash scripts. I know, I know... but sorry, I love bash scripts. They should run fine in almost all linux distributions. I try to document their usage in this **README**.

## How to:

### get_genomes_from_ftp.sh

Things you need:

- a text file with the ftp addressed of the genomes of interest, one genome per line

Usage:

assuming you cloned this repo in ~/Repos/CBAS_Symbionts

    cd directory_where_genomes_will_be_saved

    bash ~/Repos/CBAS_Symbionts/Scripts/get_genomes_from_ftp.sh . ./genome_list.txt 5 

which basically, pass the script the current working directory (.), the list of genomes to download, and an integer to avoid wget created the whole directory structure of the ncbi ftp. You can play around with this number.
 

