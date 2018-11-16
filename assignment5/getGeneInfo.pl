#! /usr/bin/perl
return 1 if ( caller() ); # for testing
use strict;
use warnings;
use feature qw(say);
#use lib '/Users/libinhuang/Desktop/BINF6200/assignment5';
use Getopt::Long; 
use Pod::Usage;
use Assignment5::MyIO qw(getFh);
use Assignment5::Config qw( 
                            getUnigeneDirectory 
                            getUnigeneExtension 
                            getHostKeywords
);





#############################################################
#
# File: getGeneInfo.pl
# History: 11-Nov-2018 (Libin Huang)
#
#############################################################
#
# This program takes two arguments: host/organism name, and gene name 
# and returns the number of places that the gene is expressed in the
# organism, and a list of the location of the expression
#
# It has the following command options:
#
# -host   name of the host species
# -gene   name of the gene
# -help   Show this message
#-------------------------------------------------------------
# Call the program like:
#
# getGeneInfo.pl -host horse -gene API5
#
# or run by default:
#
# getGeneInfo.pl
#
# which returns the expression info of TGM1 gene in humans.
#
#############################################################

#-------------
# CLI options
#-------------


###############################################################
# Command line options
###############################################################


my $usage = "\n$0 [options]\n\n
Options:

    -host   Name of the host
    -gene   Gene of interest
    -help   Show this message

";

GetOptions(
    'host=s'                => \my$host,
    'gene=s'                => \my$gene,
    help                 => sub { pod2usage($usage); }
    )
or pod2usage(2);


################################################################################
#                                   Main                                       #------------------------------------------------------------------------
################################################################################

if ((!defined $host) or (!defined $gene)){                                      # Set the default values for the program
    $host = 'Human';
    $gene = 'TGM1';
}

my$hostname = modifyHostName($host);                                            # get the modified host name

$host = $hostname;                                      
$gene = uc($gene);                                                              # upper case the gene value to remove the influence of cases

my $file = join("/", getUnigeneDirectory(), $host, $gene . '.' . getUnigeneExtension() );       # get the file address

$hostname=~ s/_/ /;                                                             # remove the "_" in the hostname for output

#say $host, " ", $gene;
#say $hostname;
#say $file;

if ( isValidGeneFileName($file) ){                                              # varify if the file exist
   say "\nFound Gene $gene for $hostname";
} 
else{
   say "Gene $gene is Not Found";
   exit;
}

my $tissues = getGeneData($host,$gene);                                         # get the array reference of the gene expression tissue list

#say foreach(@$tissues);

printOutput($gene, $hostname, $tissues);                                        # print out the results


my$hashRef = getHostKeywords();
my $hashSize = keys %$hashRef;


##################################################################################
#                                   Subroutines                                  #----------------------------------------------------------------------
##################################################################################

########################################################################################
# modifyHostName($hostname)
#---------------------------------------------------------------------------------------
# The function takes one argument, the hostname, and returns the modified hostname
# if the input matches the existing name values in the hostkeywords hash
########################################################################################

sub modifyHostName{
    my $hostname = shift;
    my $hostkeyRef = getHostKeywords();
    if(exists $hostkeyRef -> {lc$hostname}){                            # find if the host name exists in the hash reference, ignore the cases
        return ($hostkeyRef -> {lc$hostname});
    }
    else {
        _printHostDirectoriesWhichExist();
        exit;
    }
};

########################################################################################
# _printHostDirectoriesWhichExist()
#---------------------------------------------------------------------------------------
# The function takes 0 argument and print out a list of available hostnames and genenames for the input
########################################################################################


sub _printHostDirectoriesWhichExist{
    say "\n";
    say
'Either the Host Name you are searching for is not in the database

or If you are trying to use the scientific name please put the name in double quotes:

"Scientific name"

Here is a (non-case sensitive) list of available Hosts by scientific name

  1. Homo_sapiens
  2. Bos_taurus
  3. Equus_caballus
  4. Mus_musculus
  5. Ovis_aries
  6. Rattus_norvegicus


Here is a (non-case sensitive) list of available Hosts by common name

  1. Human
  2. Cow
  3. Horse
  4. Mouse
  5. Sheep
  6. Rat'
};

########################################################################################
# isValidGeneFileName($filename)
#---------------------------------------------------------------------------------------
# The function takes one argument, a file address, and returns a bolean telling if the file exists.
########################################################################################

sub isValidGeneFileName{
    my $filename = shift;
    if(-e $filename){
        return 1;
    }
    else {
        return;
    }
};

########################################################################################
# getGeneData($host,$gene)
#---------------------------------------------------------------------------------------
# The function takes two arguments, a hostname and a gene name, and returns an array
# reference containing a list of tissues where the gene is expressed
########################################################################################

sub getGeneData{
    my ($host, $gene) = @_;
    my $infile = join("/", getUnigeneDirectory(), $host, uc($gene) . '.' . getUnigeneExtension() );
    my $Fh = getFh('<',$infile);
    my @expression;
    while(<$Fh>){
        chomp;
        if(/^EXPRESS\s+(.*)/){                                               # find the line that start with "EXPRESS
        my$tissues = $1;
        @expression = split/\|/, $tissues;                                   # split the elements by '|'
        map(s/^\s//, @expression);                                           # remove the space at the beginning of each element
        map(s/(\w)/\u$1/, @expression);                                      # upper case the first letter of each element
        @expression = sort @expression;                                      # sort the tissues in alphabetical order
        return \@expression;
        }
        else {
            next;
        }
    }
    
    };


########################################################################################
# printOutput($genename, $hostname,$geneDataReference)
#---------------------------------------------------------------------------------------
# The function takes three arguments, the gene name, the host name, and the array
# reference that contains a list of tissues where the gene is expressed
########################################################################################

sub printOutput{
    my($genename, $hostname, $geneDataRef) = @_;
    say "In $hostname, There are ", scalar@$geneDataRef, " tissues that $genename is expressed in: \n";
    my $count;
    my $number;
    foreach (@$geneDataRef){
        $count++;
        $number = sprintf("%2d",$count);
        say "$number\. $_";
    }
};

