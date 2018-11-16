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
