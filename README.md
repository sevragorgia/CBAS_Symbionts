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
 
### make_genome_blastdb.sh

This script assumes that:
- you have a bunch of folders with genomes inside. Say you ran the previous script and got 45 genomes into folders with names like *GCF_90008545.1_ASM908857v1*.
- Inside these folders you should have gziped files with the proteins (\*.faa.gz) and the CDSs (\*_cds_from_genomic.fna.gz) and you want to make blast databases using these files for each genome.

Usage:

    cd directory_where_genomes_are_stored
    bash ~/Repos/CBAS_Symbionts/Scripts/make_genome_blastdb.sh nucl _cds_from_genomic.fna
    bash ~/Repos/CBAS_Symbionts/Scripts/make_genome_blastdb.sh prot .faa

Note that you can use whatever arbitrary second parameter to select other files in the folder, say for instance you don't want the CDSs but the genomic contigs, you can use \_genomic.fna as the parameter to tell the script to unzip this file and use it to build a blastdb with it. Also note that only nucl and prot are valid first parameters and that these are the makeblastdb options to indicate whether the DB is protein or nucleotides. I am not catching any errors here, blast will not work if you use something different here.

### split_multifasta.sh

This is a small script to split a multifasta file containing N sequences like:

    >header0
    Sequence0
    >header1
    Sequence1
    .
    .
    .
    >headerN
    SequenceN

into N files with only one sequence. This is useful to get the blast agains the genomes easily done, as one can use each fasta file as blast input.

Usage:

    bash split_multifasta ~/path_to_multifasta_file Number_of_lines_to_split_the_file

In the case of the example above:

    bash split_multifasta ~/path_to_multifasta_file 2

The script will use the file name of the multifasta file to generate the file names of the new fasta files. A number will be appended to the file name.


### blast_fasta_against_genomes.sh

This script can be used to blast the set of proteins in a genome of interest against a blast db containing proteins present in another genome. If you have multiple folders with genomes, each with a blast db, you can use the script to blast the set of proteins agains all genomes.

Assuming your CWD is the folder where you genomes are stored:

Usage:

    bash ~/Repos/CBAS_Symbionts/Scripts/blast_fasta_against_genomes.sh Path_to_tarball_with_protein_fasta_files Path_to_genomes_root max_number_of_sequences evalue
    bash ~/Repos/CBAS_Symbionts/Scripts/blast_fasta_against_genomes.sh ~/Repos/CBAS_Symbionts/Sspongiarum/CBAS_Sspongiarum_proteins.tar.gz . 1 1e-3

this will:

- unzip the tarball in the genome root (.)
- blast each protein fasta file against all the genomes in the genome root and save an output file with the same name of the protein fasta file. These output files will be saved inside each of the genome folders.


### Sort_proteins_by_presence_absence.sh

This script can be run after blast_fasta_against_genomes.sh has been used to produce blast outfiles per protein of interest. It takes advantage of the fact that if a match for a given protein cannot be found using blast, blast produces an empty output file. This script will sort empty output files into a folder called Proteins_Absent and files with some content into a folder called Proteins_Present. While the files are sorted the script produces output of indicating the genome name, the protein name and whether it is present or absent in the genome. If this output is catched it produces a table with the presence/absence of the proteins by genome. This table can be used in further analyses.

Usage:

    bash ~/Repos/CBAS_Symbionts/Scripts/Sort_proteins_by_presence_absence.sh Suffix_of_output_files >output_file.csv

Assuming your cwd is the folder where all the genomes are stored:

    bash ~/Repos/CBAS_Symbionts/Scripts/Sort_proteins_by_presence_absence.sh CBAS_ >presence_absence_by_genome_table.csv










