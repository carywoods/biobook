use strict;
use DBI;
use lib "$ENV{'HOME'}/bbp/";
use DbUtilsMER;
use constant TRUE
=> 1;
use constant FALSE
=> 0;
my $dbh = MERconnectDB
or die "Connect failed: ", $DBI::errstr, ".\n";
my $sql = qq/ select accession_number, sequence_data,
sequence_length from dnas /;
my $sth = $dbh->prepare( $sql );
while ( TRUE )
{
my $sequence_found = FALSE;
print "Please enter a sequence to check ('quit' to end): ";
my $to_check = <>;
chomp( $to_check );
$to_check = lc $to_check;

Databases and Perl
if ( $to_check =~ /^quit$/ )
{
last;
}
$sth->execute;
while ( my ( $ac, $sequence, $sequence_length ) = $sth->fetchrow_array )
{
$sequence =~ s/\s*//g;
if ( $sequence =~ /$to_check/ )
{
$sequence_found = TRUE;
print "The EMBL entry in the database: ",
$ac,
" contains: $to_check.\n";
print "[Lengths: ",
length $sequence,
"/$sequence_length]\n\n";
}
}
if ( !$sequence_found )
{
print "No match found in database for: $to_check.\n\n";
}
$sth->finish;
}
$dbh->disconnect;
Before describing the inner workings of the db match embl program, let's take
a look at the program in action. Here's a captured usage session, showing the
messages produced and the input provided by the user (again shown in italics):
Please enter a sequence to check ('quit' to end): aattgc
The EMBL entry in the database: AF213017 contains: aattgc.
[Lengths: 6838/6838]
Please enter a sequence to check ('quit' to end): aatttc
The EMBL entry in the database: AF213017 contains: aatttc.
[Lengths: 6838/6838]
The EMBL entry in the database: J01730 contains: aatttc.
[Lengths: 5747/5747]
Please enter a sequence to check ('quit' to end): accttaaatttgtacgtg
No match found in database for: accttaaatttgtacgtg.
[Lengths: 6838/6838]
Please enter a sequence to check ('quit' to end): aatgc
The EMBL entry in the database: AF213017 contains: aatgc.