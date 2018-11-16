use strict;
use warnings;
use feature qw(say);

# # # how to think about a "column"
# # my $line = "1\t2\t3\t4";
# # my $total = 0;
# # my @cols = split(/\t/, $line);
# # $total += $cols[0];
# # my $line2 = "2\t4\t6\t8";
# # my @cols = split(/\t/, $line2);
# # $total += $cols[0];
# # my $line3 = "3\t6\t9\t12";
# # my @cols = split(/\t/, $line3);
# # $total += $cols[0];
# # say($total);


# overview of principles of coding in Perl
# my @nameList = ("Thadryan", "Chesley", "Verenna", "Chuck");
#
# # iterating over an array
# foreach my $name(@nameList) {
#   say($name);
# }
#
# # same but with default variable
# for(@nameList) {
#   say($_);
# }
#
# # while loop
# my $counter = 0;
# while($counter < 10) {
#   say($counter);
#   $counter++;
# }

my $filename = "l.csv";

open(my $fh, '<', $filename);

unless($ARGV[0]) {
  die("You didn't give me a colum number");
}

unless($ARGV[0] < 3) {
  die("There is not enough colums");
}

say("Reading data from column: ", $arg);

my $totalOfFirstColumn = 0;

# while we're getting "my $line" from the file
while( my $row = <$fh>) {
  chomp $row;
  my @columns = split(/\,/, $row);
  $totalOfFirstColumn += $columns[$arg];
}

say("Total of column $arg: ", $totalOfFirstColumn);



### $ perl l.pl Perl is wierd! ###
# my $arg = $ARGV[0];
# say($ARGV[0]);
# say($ARGV[1]);
# say($ARGV[2]);
##################################
