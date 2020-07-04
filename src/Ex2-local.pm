#!/usr/bin/perl
use strict;
use warnings;
use Bio::SeqIO;
use Bio::Perl;
use Bio::Tools::Run::StandAloneBlastPlus;

my $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
 -db_data => '../db/swissprot',
 -create => 1
);

$fac->blastp(-query => '../data/outputs/park2.fas', -outfile => '../data/outputs/resultados-local.bls');
