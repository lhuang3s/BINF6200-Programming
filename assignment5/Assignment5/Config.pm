package Assignment5::Config;
use strict;
use warnings;
use Carp qw( confess );
use Exporter 'import';
our @EXPORT_OK = qw(getErrorString4WrongNumberArguments 
                    getUnigeneDirectory 
                    getUnigeneExtension 
                    getHostKeywords
);
use Readonly;


Readonly our $UNIGENE_DIR                           => '/Users/libinhuang/assignment5';        # '/data/PROGRAMMING/assignment5'
Readonly our $UNIGENE_FILE_ENDING                   => 'unigene';
Readonly our $HOST_KEYWORDS                         => {
                                                            'homo sapiens'      => 'Homo_sapiens',
                                                            'homo_sapiens'      => 'Homo_sapiens',
                                                            'human'             => 'Homo_sapiens',
                                                            'humans'            => 'Homo_sapiens',
                                                            'bos taurus'        => 'Bos_taurus',
                                                            'bos_taurus'        => 'Bos_taurus',
                                                            'cow'               => 'Bos_taurus',
                                                            'cows'              => 'Bos_taurus',
                                                            'equus caballus'    => 'Equus_caballus',
                                                            'equus_caballus'    => 'Equus_caballus',
                                                            'horse'             => 'Equus_caballus',
                                                            'horses'            => 'Equus_caballus',
                                                            'mus musculus'      => 'Mus_musculus',
                                                            'mus_musculus'      => 'Mus_musculus',
                                                            'mouse'             => 'Mus_musculus',
                                                            'mice'              => 'Mus_musculus',
                                                            'ovis aries'        => 'Ovis_aries',
                                                            'ovis_aries'        => 'Ovis_aries',
                                                            'sheep'             => 'Ovis_aries',
                                                            'sheeps'            => 'Ovis_aries',
                                                            'rattus norvegicus' => 'Rattus_norvegicus',
                                                            'rattus_norvegicus' => 'Rattus_norvegicus',
                                                            'rat'               => 'Rattus_norvegicus',
                                                            'rats'              => 'Rattus_norvegicus',
}; 
Readonly our $ERROR_STRING_FOR_BAD_NUMBER_ARGUMENTS => "\nIncorrect number of arguments in call to subroutine. ";


=head1 NAME

Assignment5::Config - package to show how to create a config file

=head1 SYNOPSIS

Creation:

    use Assignment5::Config qw( getErrorString4WrongNumberArguments );

    sub initializeChr21Hash{
        my $filledUsage = join(' ' , 'Usage:' , (caller(0))[3]) . '($refHash, $infile)';
        # test the number of arguments passed in were correct 
        @_ == 1 or confess getErrorString4WrongNumberArguments() , $filledUsage;
        
        my ($infile) = @_; 

        return;
    }

=head1 DESCRIPTION

This module was designed to be used by the Assignment 5 programs, and show how to create
a configuration Perl package.

=head1 EXPORTS

=head2 Default behavior

Nothing by default. 

use Assignment5::Config qw( getErrorString4WrongNumberArguments );

=head1 FUNCTIONS

=head2 getErrorString4WrongNumberArguments

   Arg [1]    : No Arguments

   Example    : @_ == 1 or confess getErrorString4WrongNumberArguments() , $filledUsage;

   Description: This will return the error string defined by constant $ERROR_STRING_FOR_BAD_NUMBER_ARGUMENTS 
                One can use to get a generic string for error handling when the incorrect number of 
                parameters is called in a Module.

   Returntype : A scalar

   Status     : Stable

=cut
sub getErrorString4WrongNumberArguments{
    my $filledUsage = join(' ' , 'Usage:', (caller(0))[3]) . '()';
    # test the number of arguments passed in were correct 
    @_ == 0 or confess $ERROR_STRING_FOR_BAD_NUMBER_ARGUMENTS , $filledUsage;
    return $ERROR_STRING_FOR_BAD_NUMBER_ARGUMENTS;
}
=head2 getUnigeneDirectory

   Arg [1]    : No Arguments

   Example    : my $unigeneDirectory = getUnigeneDirectory(); 

   Description: This will return the directory for the unigene files 

   Returntype : A scalar

   Status     : Stable

=cut
sub getUnigeneDirectory{
    my $filledUsage = join(' ' , 'Usage:', (caller(0))[3]) . '()'; 
    @_ == 0 or confess $ERROR_STRING_FOR_BAD_NUMBER_ARGUMENTS , $filledUsage;
    return $UNIGENE_DIR;
}

=head2 getUnigeneExtension

   Arg [1]    : No Arguments

   Example    : my $fileExtension = getUnigeneExtension(); 

   Description: This will return the extension of the file 

   Returntype : A scalar

   Status     : Stable

=cut
sub getUnigeneExtension{
    my $filledUsage = join(' ' , 'Usage:', (caller(0))[3]) . '()'; 
    @_ == 0 or confess $ERROR_STRING_FOR_BAD_NUMBER_ARGUMENTS , $filledUsage;
    return $UNIGENE_FILE_ENDING;
}

=head2 getHostKeywords

   Arg [1]    : No Arguments

   Example    : my $hostKeywords = getHostKeywords(); 

   Description: This will return the hash reference of keywords for the host names. 

   Returntype : A scalar (hash reference)

   Status     : Stable

=cut
sub getHostKeywords{
    my $filledUsage = join(' ' , 'Usage:', (caller(0))[3]) . '()';
    
    @_ == 0 or confess $ERROR_STRING_FOR_BAD_NUMBER_ARGUMENTS , $filledUsage;
    return $HOST_KEYWORDS;
}



=head1 CONTACT

Libin Huang, << <huang.lib at husky.neu.edu> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2018 Libin Huang.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>


=head1 SETTING PATH

If you did not setup your PERL5LIB, you need to do the following things:

use lib '/home/huang.lib/programming6200/assignment5';

or add the following path to your .bashrc:

PERL5LIB=/home/huang.lib/programming6200/assignment5

export PERL5LIB
=cut
1;          # End of Assignment5::Config
