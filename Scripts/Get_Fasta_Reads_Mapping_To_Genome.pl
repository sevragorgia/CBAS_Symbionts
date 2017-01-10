#!/usr/bin/perl -w

use strict;
use warnings;
use Getopt::Long;

#ADD GNU license here!


#command line options, the variable names should be self explanatory;
my $fasta_file;
my $mapping_results;
my $output_file;
my $verbose;
my $debug;

my $help = "The following options have to be provided:
    --fasta_file = the fasta file with the reads
    --mappings = a sam file with the graphmap results
    --output_file = path for the output (fasta) file
	--verbose F
 	--debug F

A normal command line would look like:
	perl Get_Fasta_Reads_Mapping_To_Genome.pl --fasta_file cbas_nanopore.fasta --mappings all_nanopore_mapping.sam uniprot --out cbas_mapping_nanopore.fasta

";

#get options from command line
GetOptions("fasta_file=s" => \$fasta_file,
           "out=s" => \$output_file,
           "mappings=s" => \$mapping_results,
           "verbose" => \$verbose,
           "debug" => \$debug,
           "help" => \$help
           ) or die("Error in the command line arguments\n$help");

#fasta reader, expects file path and hash ref
sub read_reader{
  my $file = shift;
  my $hash_ref = shift;
  
  #initialize some counters
	my $sequence_counter = 1;
	
  #open filehandles
  open my $infile, '<', $file or die "Cannot open the reads file\n$!";
  
  my $fasta_header="";
  my $sequence="";

  #read the transcript file an populate hash
  while(<$infile>){
     chomp;
#    print if($debug);

     if(m/^>/){#in fasta header get line and split at spaces. replace the values in transcript_name and length
     
      #get rid of > at the begining of transcript name
      s/>//g;
    
      #first, is sequence is not empty is because we just finish reading one, store it using the previously stored transcript_name
      if($sequence){#note that this will only be true after reading the first header. Therefore the next push is safe.
      
        print $sequence, "\n" if($debug);
        ${$hash_ref}{$fasta_header}=$sequence;
        
        #now clear the sequence
        $sequence = "";
      
      }
      
      #we store the name of the current sequence to push in the next header.
      $fasta_header = $_;
      
      $sequence_counter++;
    }else{#in sequence, concatenate the sequence
    
      $sequence .= $_;   
    
    }
  }
  ${$hash_ref}{$fasta_header}=$sequence;#we need this push to save the last record in the file
  close $infile;
}


#table reader, expects file path, a hash ref, the fields to be extracted and the field separator
sub main {


  #check that some required options are defined;
  die "\n$help\n" unless defined $fasta_file;

  print "reading reads file", if($verbose);
  my %sequence_hash;
  
  &read_reader($fasta_file, \%sequence_hash);
  
  print "reads file read", if($verbose);
  
  #open filehandles
  open my $table, '<', $mapping_results or die "Cannot open the file\n$!";
  open my $output, '>', $output_file or die "Cannot open the file\n$!";
  
  print "reading mappings table and extracting sequences", if($verbose);
  
  while(<$table>){
    chomp;
    my @table_fields = split("\t");
    
    #note that the sequences have the same name in both files!
    if(exists $sequence_hash{$table_fields[0]}){
        
        print $output ">", $table_fields[0], "\n",  $sequence_hash{$table_fields[0]}, "\n";
    
    }
  }
  
  close $table;
  close $output;
  
  return 0;
}

exit &main; 
