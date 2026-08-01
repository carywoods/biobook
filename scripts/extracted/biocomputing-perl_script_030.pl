use strict;
use Bio::Perl;
my $ID = shift;
my $Sequence = get_sequence( 'swiss', $ID );
write_sequence( ">./seqs/$ID.swp", 'swiss', $Sequence );
write_sequence( ">./seqs/$ID.fsa", 'fasta', $Sequence );
There's not much to the simple get sequence.pl program. After switching
on strictness and using the Bio::Perl module, the $ID scalar is assigned a
value from the command-line (thanks to the shift sub-routine). This scalar is
immediately used in a call to Bioperl's get sequence sub-routine, which goes off
to the Internet and downloads the SWISS-PROT entry associated with the value
of $ID. The entry is assigned to (or associated with) the $Sequence scalar. It is
then used in two calls to Bioperl's write sequence sub-routine, which each take
the downloaded SWISS-PROT entry in $Sequence and create a disk-file from it.
The first call creates a disk-file containing the verbose format, while the second
creates a disk-file containing the FASTA format.