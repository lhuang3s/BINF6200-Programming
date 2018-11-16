#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 5;

use Test::Exception;                    # need this to get dies_ok and lives_ok to work
use Assignment5::MyIO qw(getFh);

#############################################################
#
# File: myio.t
# History: 28-oct-2018 (Libin Huang)
#
#############################################################
#
# This program test if the MyIO module works or not  
#
# NEED SETTING PATH BEFORE RUNNING
#------------------------------------------------------------
# If you did not setup your PERL5LIB, you need to do the following things:
#
# use lib '/home/huang.lib/programming6200/assignment5';
#
# or add the following path to your .bashrc:
#
# PERL5LIB=/home/huang.lib/programming6200/assignment5
#
# export PERL5LIB
#
#------------------------------------------------------------
# Call the test program like:
#------------------------------------------------------------
# perl Assignment5/t/myio.t
#
#############################################################



require_ok 'Assignment5/MyIO.pm';


my $infile = "Assignment5/t/genes.txt";
my $outfile = "Assignment5/t/genes_output.txt";

# to gest files are ok, first 
my $fhIn = getFh("<", $infile);
my $fhOut = getFh(">", $outfile);

is(ref $fhIn,  'GLOB', "The input  filehandle is a glob");
is(ref $fhOut, 'GLOB', "The output filehandle is a glob");

# dies when given the wrong type
dies_ok { getFh("<<", $infile) } 'dies ok on <<';

# dies when the type of file is not given
dies_ok { getFh("", $infile) } 'dies ok on no open type';
