use strict;
use CGI qw/ :standard *table /;
use DBI;
use lib ".";
use DbUtilsMER;
print header, start_html( "The results of your search are in!" );
my $dbh = MERconnectDB
or die "Connect failed: ", $DBI::errstr, ".\n";
my $sql = qq/ select accession_number, sequence_data,
sequence_length from dnas /;
my $sth = $dbh->prepare( $sql );
my $to_check = param( "shortsequence" );
my $print_border = param( "printborder" );
$to_check = lc $to_check;
$sth->execute;
print h3( "You searched the \"dnas\" table for this sequence: $to_check." );
if ( $print_border )
{
print start_table(
{ -border => "1" } );
}
else
{
print start_table(
{ -border => "0" } );

Web Technologies
}
print Tr( { -align => "CENTER" } ), th( "Protein Accession Code" ),
th( "Was it found?" ), th( "Length Values" );
while ( my ( $ac, $sequence, $sequence_length ) = $sth->fetchrow_array )
{
$sequence =~ s/\s*//g;
print Tr( { -align => "CENTER" } ), td( "$ac" );
if ( $sequence =~ /$to_check/ )
{
print td( "yes" );
}
else
{
print td( "no" );
}
my $calced_length = length $sequence;
print td( "$calced_length/$sequence_length" );
}
print end_table;
print p, hr,p;
print <<MERFORM;
Please enter another sequence to match against:<p>
<FORM ACTION="/cgi-bin/db_match_emblCGI">
<p>
<textarea name="shortsequence" rows="4" cols="60">$to_check</textarea>
</p>
<p>
Include a border around the results:
<input type="checkbox" name="printborder" value="on"
checked="checked" />
</p>
<p>
<input type="reset"
value="Clear">
<input type="submit" value="Try it!">
</p>
</FORM>
MERFORM
print end_html;
$sth->finish;
$dbh->disconnect;
Obviously, the majority of db match emblCGI resembles that of db match embl.
Consequently, this description concentrates on the differences between the two