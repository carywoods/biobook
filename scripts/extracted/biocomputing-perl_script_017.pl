use strict;
use DBI;
use lib "$ENV{'HOME'}/bbp/";
use DbUtilsMER;
my $dbh = MERconnectDB
or die "Connect failed: ", $DBI::errstr, ".\n";
my $sql = "select * from crossrefs";
my $sth = $dbh->prepare( $sql );
$sth->execute;
print "There are ", $sth->rows, " cross references in the database.\n\n";
while ( my @row = $sth->fetchrow_array )
{
print "The protein $row[0] is cross referenced with $row[1].\n";
}
$sth->finish;
$dbh->disconnect;
As can be seen, other than the fact that the $sql scalar has a different SQL query
assigned to it, this program is very similar to the show tables2 program. The
lines of interest are these:

Databases and Perl
print "There are ", $sth->rows, " cross references in the database.\n\n";
while ( my @row = $sth->fetchrow_array )
{
print "The protein $row[0] is cross referenced with $row[1].\n";
}
The rows subroutine, invoked through the statement handle, returns the number
of rows contained in the results, and the value is used within the opening
message.
The while loop processes the results, employing fetchrow array to return
each row of data and assign it to @row. The crossrefs table has two columns, so
knowing this, each column's data can be accessed using standard array indexing
notation. The first column is therefore referred to as $row[0] and the second
column is referred to as $row[1]. The which crossrefs program exploits this
when producing the message for each cross reference.
An alternative to using array indices is to assign the array returned from
fetchrow array to a list of named scalars. This technique is implemented in
which crossrefs2 and involves changing the condition-part of the loop, as well
as the print statement within the loop block:
while ( my ( $protein, $dna ) = $sth->fetchrow_array )
{
print "The protein $protein is cross referenced with $dna.\n";
}
This loop produces the same output as the loop used in which crossrefs.
The third technique uses the names of the columns to reference the values
contained in them. Rather than invoke fetchrow array, the which crossrefs3
program employs fetchrow hashref to return a reference to a hash. The name-
parts of this referenced hash are set to the names of the columns in the table,
while the value-parts in the referenced hash are set to the values associated with
each individual row. The hash reference is assigned to the $row scalar, then the
values are accessed as follows:
while ( my $row = $sth->fetchrow_hashref )
{
print "The protein $row->{ ac_protein } is cross referenced ";
print "with $row->{ ac_dna }.\n";
}
The hash name-parts are identical to the column names as defined in the cross-
refs table within the MER database.
both which crossrefs and which crossrefs2. Which technique is used often
depends on personal preference, as they all work. The final technique, using a