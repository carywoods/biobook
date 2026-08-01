use CGI qw/:standard/;
use strict;
my %Seq_Details;
A while loop cycles through the disk-file, one line at a time:
while ( <> )
{
Each iteration begins by skipping any lines that are not header lines:
unless ( /^>s[w|p]\|/ )
{
next;
}
are used to initialise three scalars (note that the $tmp scalar is not actually used
in this program):

Data Visualisation
my ( $tmp, $Accession, $ID ) = split( /\|/, $_ );
Two regular expressions extract the accession code and the gene identifier,
assigning them to appropriately named scalar variables:
$ID = $ID =~ m/(^[\w\d]*) /;
my $Gene = $ID =~ m/(.*)_/;
With the accession code and gene identifier known, the next line of code records
the details in the $Seq Details hash, then the loop iteration ends:
$Seq_Details{ $Gene }{ $Accession } =
$ID;
}
The code that updates the hash demonstrates a new technique. Typically (and
hash within a hash is exploited4.
With the entire disk-file processed, the Mer Table.pl program proceeds to
create the HTML visualisation. It starts by beginning the HTML web page, and
printing a HTML Level 1 header:
print start_html( "Summary of SWISS-PROT 'Mer' Operon Genes" ), "\n";
print h1( "Summary of 'Mer' Genes" );
A print statement starts the table, then a collection of invocations of the table
row and heading producing subroutines from the CGI module occur:
print "<TABLE WIDTH=100% BORDER = 2>\n";
print Tr, th( "Gene" ), th( "Accession Codes" ), th( "Gene IDs" ), "\n";
A foreach statement is used to cycle through the data stored within the
%Seq Details hash. Note how the name-parts of the hash are extracted (using
keys), sorted (using sort) and then assigned with each iteration to the $Gene
scalar. The body of the foreach loop starts by creating a HTML table row:
foreach my $Gene ( sort keys %Seq_Details )
{
print "<TR>\n", th ($Gene), "\n<TD>";
An inner foreach loop then processes the accession codes associated with the
that is %Seq Details:
puting and Perl. Refer to the perldsc manual page for a good introduction.