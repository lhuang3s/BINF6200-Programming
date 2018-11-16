#! /usr/bin/perl
use strict;
use warnings;
use feature qw(say);
use Scalar::Util qw(looks_like_number);

#############################################################
#
# File: descriptiveStatistics.pl
# History: 25-sep-2018 (Libin Huang)
#
#############################################################
#
# This is a program that calculates descriptive statistics for the sepecific column of a given input file.
#
# A sample command for executing the program is :
# perl descriptiveStatistics [FileName] [column number]
#
#############################################################

my $filename = $ARGV[0];
my $column_to_parse = $ARGV[1];

#say ($filename);
#say ("\n\n    Column:\t", "$column_to_parse");

open(my $fh, "<", "$filename");

##############################################################
#
# @column_data stores the data from the column to parse.
#
##############################################################

my @column_data;
my @row_values;
while (my $row =<$fh>) {
    chomp $row;
    @row_values = split(/\t/,$row);
    push(@column_data, $row_values[$column_to_parse]);
}
=cut
foreach(@column_data){
    say $_;
}
=cut

my @column_values = @column_data;  # store the data to another array just in case
###############################################################
#
# $Count gets the count of values in the column to parse.
#
###############################################################

my $Count = scalar@column_values;


#printf("\n\nCount\t  =\t%.3f\n", $Count);

################################################################
#
# @valid_data stores the data that are numbers, @invalid_data stores values that are not numbers,
# including "NaN" and "inf", for which the looks_like_number() function returns a value of 36 and 20 instead of 0.
#
################################################################

my @invalid_data;
my @valid_data;

for(my$i = 0; $i< $Count; $i++){
    
if(looks_like_number($column_values[$i])==0 or ($column_values[$i] eq "NaN") or ($column_values[$i] eq "inf")){
        push (@invalid_data, $column_values[$i]);      
}
else {
    push(@valid_data, $column_values[$i]);
}
}

my $valid_Num = scalar(@valid_data);

#say ("invalid data are:");
#say foreach (@invalid_data);
#say ("valid data are:"); 
#say foreach (@valid_data);

#say foreach(@valid_data);
#say scalar@valid_data;

#my $valid = looks_like_number($column_values[0]);
#say "value is: ", $column_values[0];
#say "value is ", $valid;

#my $var = "inf"; my $var2 = "NaN";
#my $isnum = looks_like_number( $var ); my $isnum2 = looks_like_number( $var2 );
#say "value for inf is: ", $isnum, "\nvalue for NaN is: ", $isnum2;


#printf("valid_Num =\t%.3f\n", $valid_Num);


############################################################
#
# $total gets the sum of the valid_data,
# sub Average ($number, @valid_data)
#
############################################################
#
# This function takes two arguments, the number of values and a data list,
# and returns the average of the data list.
#
############################################################
sub Average {
my $total=0;
my ($number, @valid_data) = @_;
for(my $j = 0;$j < $number; $j++){
    $total= $total + $valid_data[$j];
}

my $Average = $total / $number;
}


#say (join(' ', "total", "=", "$total"));
#printf ("Average   =\t%.3f\n", $Average);

################################################################
#
# sub Maximum (@sort_dataR), sub Minimum(@sort_data)
#
################################################################
#
# sub Maxmium gets a data sorted in descending order and returns the first value of the list
# sub Minmum get a data list sorted in ascending order and returns the first value 
#
################################################################

my @sort_data = sort @valid_data;

my @sort_dataR = reverse @sort_data;


sub Minimum {
    my @sort_data = @_;
    my $Minimum = $sort_data[0];
}

sub Maximum {
    my @sort_dataR = @_;
    my $Maximum = $sort_dataR[0];
}


#printf ("Maximum   =\t%.3f\nMinimum   =\t%.3f\n", $Maximum, $Minimum);

################################################################
#
# Variance ($num_of_count, $Average)
# Std Dev ($Variance)
#
################################################################
#
# Variance() gets two arguments, the number of values and the average of the data set,
# and returns the variance of the data set.
# Std_Dev() gets the variance and returns the standard deviation.
#
################################################################
sub Variance{
my $sum=0;
my $Variance;
my ($valid_Num, $Average) = @_;
for(my $i = 0;$i < $valid_Num; $i++){
    $sum= $sum + ($Average-$valid_data[$i])**2;
}

if($valid_Num - 1 == 0) {
    $Variance = 0;
}
else {
    $Variance = $sum / ($valid_Num-1);
}
}


sub Std_Dev{
    my $Variance = shift;
    my $Std_Dev = sqrt($Variance);
}


#printf("Variance  =\t%.3f\n", $Variance);
#printf("Std Dev   =\t%.3f\n",$Std_Dev);

#################################################################
#
# sub Median($num_of_count,@sorted_data)
#
#################################################################
#
# This function takes two arguments, the number of values and a sorted data list (in either ascending or descending order),
# and returns the median of the data list.
#
#################################################################


sub Median{
my ($valid_Num, @sort_data) = @_;
my $Median;

if ($valid_Num % 2 == 1) {
    my $mid_num = int($valid_Num / 2);
    $Median = $sort_data[$mid_num];
}
else {
    my $mid_numA = ($valid_Num / 2) - 1;
    my $mid_numB = ($valid_Num /2);
    $Median = ($sort_data[$mid_numA]+$sort_data[$mid_numB]) / 2;
}
}

#printf("Median    =\t%.3f\n",$Median);

###################################################################
#
# If there is no number in the column, the program dies and returns an error message,
# if the column number input is larger than the existing largest column number in the datafile,
# the program dies and returns an error message.
# Otherwise, it will return the descriptive statistics of the data file.
#
###################################################################

if($column_to_parse > scalar(@row_values) and $valid_Num == 0){
    die ("The column ",$column_to_parse, " does not exist in ", $filename, ", column number should be less than ", scalar(@row_values))
}
elsif($valid_Num == 0 and $column_to_parse <= scalar(@row_values)){
    die ("There is no valid number in column ", $column_to_parse,"$!")
}
else{
    my $Average = Average($valid_Num,@valid_data);
    my $Minimum = Minimum (@sort_data);
    my $Maximum = Maximum (@sort_dataR);
    my $Variance = Variance($valid_Num, $Average);
    my $Std_Dev = Std_Dev($Variance);
    my $Median = Median($valid_Num, @sort_data);
    
    say ("\n\n    Column:\t", "$column_to_parse");
    printf("\n\nCount\t  =\t%.3f\n", $Count);
    printf("validNum  =\t%.3f\n", $valid_Num);
    printf ("Average   =\t%.3f\n", $Average);
    printf ("Maximum   =\t%.3f\nMinimum   =\t%.3f\n", $Maximum, $Minimum);
    printf("Variance  =\t%.3f\n", $Variance);
    printf("Std Dev   =\t%.3f\n",$Std_Dev);
    printf("Median    =\t%.3f\n",$Median);
}