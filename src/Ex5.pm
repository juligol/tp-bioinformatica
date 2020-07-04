#!/usr/bin/perl
use strict;
use warnings;
use Bio::SeqIO;
use Bio::Factory::EMBOSS;
use Bio::Tools::Run::WrapperBase;

# Read genbank file
my $input = Bio::SeqIO->new(
    -format => 'genbank',
    -file   => '../data/inputs/park2.gb',
);

# Call EMBOSS
my $factory = new Bio::Factory::EMBOSS;

# Read sequence
while (my $sequence = $input->next_seq()) {
    # Calculate orfs
    my $orf = $factory->program('getorf'); 
    my %orfsInput = (
        -sequence => $sequence,
        -minsize => 22,
        -outseq => "../data/outputs/orfs.fas"
    );
    $orf->run(\%orfsInput);
    # Analysis with patmatmotifs
    my $patmatmotifs = $factory->program('patmatmotifs'); 
    my %patmatmotifsInput = (
        -sequence => $sequence,
        -full => 1,
        -outfile => "../data/outputs/results.patmatmotifs"
    );
    $patmatmotifs->run(\%patmatmotifsInput);
}
