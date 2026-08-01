use strict;
use Bio::Perl;
while ( my $ID = <> )
{
chomp( $ID );
print "Fetching Sequence: $ID.\n";
my $Sequence = get_sequence( 'swiss', $ID );
write_sequence( ">./seqs/$ID.swp", 'swiss', $Sequence );
write_sequence( ">./seqs/$ID.fsa", 'fasta', $Sequence );
}