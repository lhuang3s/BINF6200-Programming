package Assignment5::MyIO;

use strict;
use warnings;
use Carp qw( confess );
use Exporter 'import';
our @EXPORT_OK = qw(getFh);
use Assignment5::Config qw(getErrorString4WrongNumberArguments);



=head1 NAME

Assignment5::MyIO - package to handle opening of files and passing filehandles


=head1 SYNOPSIS

Creation:

   use Assignment5::MyIO qw(getFh);
   my $infile = 'testfile.txt'              
   my $fh = getFh('<', $infile);        # get a filehandle for reading

=head1 DESCRIPTION

This module was designed to be used by the Assignment 5 programs, and show how to create
a Perl package used for IO

=head1 EXPORT

=head2 Default behavior

Nothing by default. 

use Assignment5::MyIO qw( getFh );

=head1 FUNCTIONS

=head2 getFh

   Arg [1]    : Type of file to open, reading '<', writing '>', appending '>>'
   Arg [2]    : A name for the file

   Example    : my $fh = getFh('<', $infile);

   Description: This will return a filehandle to the file passed in. This function
                can be used to open, write, and append, and get the File Handle.
                It is recommended to give the absolute path for the file.

   Returntype : A filehandle

   Status     : Stable

=cut

sub getFh {
    my ($mark, $file) = @_;
    
    my $filledUsage = join(' ' , 'Usage:', (caller(0))[3]) . '()'; 
    @_ == 2 or confess getErrorString4WrongNumberArguments() , $filledUsage;            # check if the number of arguments is correct
    
    if ($mark eq '<') {
        open(my$fhIn, '<', $file);
        return($fhIn);
    }
    elsif ($mark eq '>') {
        open(my$fhOut, '>', $file);
        return($fhOut);
    }
    elsif ($mark eq '>>') {
        open(my$fhOut, '>>', $file);
        return($fhOut);
    }
    else{
        die ("Symbol should be either < , > or >>", "$!");
    }
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

1; # End of Assignment5::MyIO
