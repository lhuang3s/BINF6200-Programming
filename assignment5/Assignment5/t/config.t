#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 7;
use Test::Exception;                    # need this to get dies_ok and lives_ok to work


#############################################################
#
# File: config.t
# History: 11-Nov-2018 (Libin Huang)
#
#############################################################
#
# This program test if the Config module works or not
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
#
# Call the test program like:
#------------------------------------------------------------
# perl Assignment5/t/config.t
# 
#############################################################

BEGIN { use_ok('Assignment5::Config', qw(getErrorString4WrongNumberArguments 
                                        getUnigeneDirectory 
                                        getUnigeneExtension 
                                        getHostKeywords)
    );
}

require_ok 'Assignment5/Config.pm';

dies_ok { getErrorString4WrongNumberArguments(1) } 'dies ok when an argument is passed';
is(getUnigeneDirectory(), '/Users/libinhuang/assignment5', 'getUnigeneDirectory() works correctly');
is(getUnigeneExtension(), 'unigene', 'getUnigeneExtension() works correctly');

my $hashRef = getHostKeywords();
my $hashSize = keys %$hashRef;
my $hostname = $hashRef -> {'humans'};

is($hashSize, '24', 'The hash size from getHostKeywords() is correct');
is($hostname, 'Homo_sapiens', 'getHostKeywords() returns correct key-value pair');
