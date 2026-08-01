use strict;
use DBI;
use lib "$ENV{'HOME'}/bbp/";
use DbUtilsMER;
use constant TRUE => 1;
my $dbh = MERconnectDB
or die "Connect failed: ", $DBI::errstr, ".\n";
my $sql = qq/ select ac_dna from crossrefs where ac_protein = ? /;
my $sth = $dbh->prepare( $sql );
while ( TRUE )
{
print "\nProvide a protein accession number to cross ";
print "reference ('quit' to end): ";
my $protein2find = <>;
chomp $protein2find;
$protein2find = uc $protein2find;
if ( $protein2find eq 'QUIT' )
{
last;
}
$sth->execute( $protein2find );
my $dna = $sth->fetchrow_array;
$sth->finish;
if ( !$dna )
{
print "Not found: there is no cross reference for that protein ";
print "in the database.\n";
}