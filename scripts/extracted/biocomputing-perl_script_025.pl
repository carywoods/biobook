use CGI qw/ :standard *table /;
use DBI;
use lib ".";
use DbUtilsMER;
After starting to create the HTML page and making a connection to the database,
the appropriate SQL query is assigned to the $sql scalar:
my $sql = qq/ select accession_number, sequence_data,
sequence_length from dnas /;
A straightforward SELECT query extracts three named columns of data from the
dnas table. After preparing the statement, the program determines the values
associated with the textarea and the checkbox interface elements from the HTML
form within the mersearchmulti.html web page. The param subroutine from
the CGI module handles this for us:
my $to_check = param( "shortsequence" );
my $print_border = param( "printborder" );
The value associated with the printborder checkbox is then used to determine
whether the table includes a border around each table entry. If printborder is
checked, the table is created by invoking the start table subroutine (included
with CGI) with a referenced parameter that sets the -border attribute to one. If
the checkbox is not checked, the -border attribute is set to zero:
if ( $print_border )
{
print start_table(
{ -border => "1" } );
}
else
{
print start_table(
{ -border => "0" } );
}

Web Technologies
With the table started, the next thing to do is create a table row for the column
headings. Again, the CGI module provides subroutines to help with this: Tr
creates a new table row, and th creates a new table heading. Note the table row
has its alignment attribute set to centred:
print Tr( { -align => "CENTER" } ), th( "Protein Accession Code" ),
th( "Was it found?" ), th( "Length Values" );
A while loop iterates over each row of the results, assigning the three col-
umn values returned from the database system to the $ac, $sequence and
$sequence length scalars. Within the loop's body, these scalar values are used
to determine the content of each of the rows of the HTML table. The $sequence
scalar has any space character removed from its value. The table row is then
started, with the protein accession number (contained in $ac) positioned within
the first cell of the table (thanks to the td subroutine from CGI). If the value
contained in $to check is found within the $sequence scalar, the next table
ing the length of the $sequence scalar, the value is used together with the
$sequence length scalar to populate the final table cell of the table row:
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
When the loop ends, that is, when there are no more rows of data to process
from the database system, the db match emblCGI program ends the table and
then displays the HTML form from the mersearchmulti.html web page. Note
the use of the $to check scalar within the HERE document to set the value of the
textarea within the form7. The program ends by concluding the HTML page, then
finishing the SQL query and terminating the database connection.
