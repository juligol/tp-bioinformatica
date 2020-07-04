#!/usr/bin/perl
use strict;
use warnings;
use Bio::SearchIO;
use Bio::SeqIO;
use Bio::DB::GenPept;

my $search = $ARGV[0];
my $pattern = $ARGV[1];

# Read blast file
my $input = Bio::SearchIO->new(
    -format => 'blast',
    -file   => $search
);

# Create fasta file
my $output = Bio::SeqIO->new(
    -format => 'fasta',
    -file   => '>../data/outputs/matches.fas'
);

# Create genpept temp file
my $genpept = Bio::DB::GenPept->new(
    -format => 'fasta',
    -retrievaltype => 'tempfile'
);

# Read results from blast file
while (my $result = $input->next_result()) {
	while(my $hit = $result->next_hit) {
	    my $name = $hit->name();
	    my $description = $hit->description;

	    # If the description contains the pattern
        if(index(lc($description), lc($pattern)) != -1) {      
            my $accession = $hit->accession();
            $output->write_seq($genpept->get_Seq_by_version($accession));
        }
	}
}
