use strict;
while ( <> )
{
if ( !/^
25/ )
{
next;
}
my @Fields = split( " ", $_ ,8 );

Non-redundant Datasets
if ( $Fields[ 7 ] / $Fields [ 2 ] > 0.7 )
{
my $ID
= substr( $Fields[ 1 ], 0, 4 );
my $Chain = substr( $Fields[ 1 ], 4, 1 );
printf( "%3s,%1s: %4i\n", $ID, $Chain, $Fields[ 7 ] );
}
else
{
print "Excluded: ", $Fields[ 1 ], "\n";
}
}
those lines that do not. The split subroutine, provided by Perl, breaks the line
into a collection of scalars that are then assigned to the @Fields array. A test is
then performed to see if the ratio of the number of amino acids in the structure
(field 2) relative to the number with side chains (field 7) exceeds 0.7 (or 70%). If
they do, then the chain and ID are split from each other. Note that the combined
code/ID is contained in field 1. An appropriately formatted message is then
displayed on STDOUT.
The select filter program produces a list that contains the PDB identifier
.
.
.
Excluded: 1C53_
Excluded: 1TIA_
.
.
.
such as 1TIA that has 271 amino acids but only 3 complete side chains. The lines
created by the excluded structures/chains can be removed by piping the output