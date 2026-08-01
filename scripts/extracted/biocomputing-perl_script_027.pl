use CGI qw/:standard/;
use strict;
my %Seq_Details;
while ( <> )
{
unless ( /^>s[w|p]\|/ )
{
next;
}
my ( $tmp, $Accession, $ID ) = split( /\|/, $_ );
$ID = $ID =~ m/(^[\w\d]*) /;
my $Gene = $ID =~ m/(.*)_/;
$Seq_Details{ $Gene }{ $Accession } =
$ID;
}
print start_html( "Summary of SWISS-PROT 'Mer' Operon Genes" ), "\n";
print h1( "Summary of 'Mer' Genes" );
print "<TABLE WIDTH=100% BORDER = 2>\n";