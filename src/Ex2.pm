#!/usr/bin/perl
use strict;
use warnings;
use Bio::Perl;

# Read fasta file
my $input = Bio::SeqIO->new(
    -format => 'fasta',
    -file   => '../data/outputs/park2.fas',
);
 
# Read sequence
while (my $sequence = $input->next_seq()) {
    # Convert to blast sequence
    my $blast_result = blast_sequence($sequence->seq);
    # Write blast sequence in report.blast file
    write_blast('>>../data/outputs/report.blast', $blast_result);
}
