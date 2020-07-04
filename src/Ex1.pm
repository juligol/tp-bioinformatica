#!/usr/bin/perl
use strict;
use Bio::Seq;
use Bio::SeqIO;

# Read genbank file
my $input = Bio::SeqIO->new(
    -format => 'genbank',
    -file   => '../data/inputs/park2.gb',
);

# Create fasta file
my $output = Bio::SeqIO->new(
    -format => 'fasta',
    -file   => '>../data/outputs/park2.fas',
);

while (my $sequence = $input->next_seq()) {
    # See park2.gb file, CDS section
    my $sub_sequence = $sequence->subseq(99, 1496);
    my $prot_obj = Bio::Seq->new(-seq => $sub_sequence)->translate();
    $output->write_seq($prot_obj);
}
