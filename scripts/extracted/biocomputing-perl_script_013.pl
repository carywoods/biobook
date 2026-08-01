use strict;
my ( $table_line, $code, $species );
while ( <> )
{
if ( /^ID
(.+)_(.+?) / )
{
( $code, $species ) = ( $1, $2 );

Databases
}
if ( /^AC
(.+?);/ )
{
$table_line = $1 . "\t" . $code . "\t" . $species . "\t";
while ( <> )
{
last unless /^AC/;
}
}
if ( /^DT/ )
{
my $date_line = $_;
while ( <> )
{
last unless /^DT/;
$date_line = $_;
}
$date_line =~ /^DT
(.+?) /;
$table_line = $table_line . biodb2mysql( $1 ) . "\t";
}
if ( /^DE
(.+)/ )
{
my $descr_lines = $1;
while ( <> )
{
last unless /^DE
(.+)/;
$descr_lines = $descr_lines . ' ' . $1
}
$table_line = $table_line . $descr_lines . "\t";
}
if ( /^SQ
(.+)/ )
{
my $header = $1;
$header =~ /(\d+)/;
$table_line = $table_line . $header . "\t" . $1 . "\t";
}
if ( /^
(.+)/ )
{
my $sequence_lines = $1;
while ( <> )
{
if ( m[^//] )
{
last;
}

A Database Case Study: MER
else
{
/^
(.+)/;
$sequence_lines = $sequence_lines . $1;
}
}
$table_line = $table_line . $sequence_lines;
}
if ( m[^//] )
{
print "$table_line\n";
$table_line = '';
}
}
Let's describe the workings of this program in detail. Take a moment to print
out a SWISS-PROT entry so that it can be referred to while working through the
description of this program.
After the standard first line and a comment, a BEGIN block pushes the location
of the Bioinformatics, Biocomputing and Perl shared code directory onto the @INC
array. This allows the program to find the utilities module developed in the
Getting Organised chapter6. A use of the utilities module comes immediately
after the BEGIN block. Note the explicit mention of the biodb2mysql subroutine,
which is used to convert the SWISS-PROT formatted date into a date format that
is acceptable to MySQL:
BEGIN {
push @INC, "$ENV{'HOME'}/bbp/";
}
use UsefulUtils qw( biodb2mysql );
Strictness is switched on, then three scalar variables are declared:
use strict;
my ( $table_line, $code, $species );
The $table line scalar holds the (soon to be constructed) tab-delimited line,
whereas the $code and $species scalars hold the extracted mnemonic protein
code and species values, respectively.
A loop is started that continues to execute while there are lines of data arriving
from standard input:
while ( <> )
{
wished to show the other popular technique for including ''local'' modules.

Databases
The current line of data is assigned to the Perl's default scalar variable, $ . Once
assigned, the line is matched against a series of patterns. The first of these
patterns looks for the ID line type:
if ( /^ID
(.+)_(.+?) / )
{
( $code, $species ) = ( $1, $2 );
}
Specifically, the pattern attempts to match against a line that starts with the
characters, the match looks for two series of one or more characters (the ''.+''
pattern), separated from each other by an underscore character, and followed by
a single-space character. If the pattern matches, the program knows it has found
an identification line type within the SWISS-PROT entry.
greedy because of the use of the ''?'' qualifier. This stops the second ''.+'' pattern
from attempting to match as much of the line as possible by forcing the pattern
to match as soon as possible.
perl to remember the matched values in the $1 and $2 scalars. These values
correspond to the mnemonic code for the protein and its associated species, and
they are used within the if block to initialise the $code and $species scalars.
The second pattern looks for the AC line type, and upon a match, the pro-
gram starts to construct the tab-delimited line. The matched accession number,
together with the code and species values, with each data value separated from
the next by a tab character, is assigned to the $table line scalar7:
if ( /^AC
(.+?);/ )
{
$table_line = $1 . "\t" . $code . "\t" . $species . "\t";
while ( <> )
{
last unless /^AC/;
}
}
Processing the AC line type is complicated by the fact that a SWISS-PROT entry
can have more than one AC line type. Additionally, there can be more than
one accession number on each AC line. Only the first accession number is of
of characters immediately followed by a semicolon, which is matched by the
non-greedy pattern ''(.+?);''.

A Database Case Study: MER
The second while loop within the if block (often referred to as an inner loop)
of the line. In this way, any additional AC line types are ignored. Note the use of
last, which when invoked ensures that the inner loop ends as soon as a line that
starts with anything other than ''AC'' is encountered.
When it comes to extracting the last date from any DT lines, the program first
needs to find the last date line. Once found, it matches against the date part of
the line, then calls the biodb2mysql subroutine to convert the SWISS-PROT date
into a format that is acceptable to MySQL. The converted date is then added to
the $table line scalar, together with a tab character:
if ( /^DT/ )
{
my $date_line = $_;
while ( <> )
{
last unless /^DT/;
$date_line = $_;
}
$date_line =~ /^DT
(.+?) /;
$table_line = $table_line . biodb2mysql( $1 ) . "\t";
}
accession number from the first AC line than ignore the rest, this if block ignores
stored in the $date line scalar, then the pattern match is applied to $date line
once there are no more DT lines to process. Again, the use of non-greedy pattern
qualifiers ensure that only the required information is matched and remembered
in the $1 scalar.
The DE line type contains the description of the protein structure. As there
can be more than one DE line type, the if block matches a pattern against the
description text, remembers the description in the $descr lines scalar, then
processes any remaining DE line types, concatenating the matched description to
the description already in $descr lines:
if ( /^DE
(.+)/ )
{
my $descr_lines = $1;
while ( <> )
{
last unless /^DE
(.+)/;
$descr_lines = $descr_lines . ' ' . $1
}
$table_line = $table_line . $descr_lines . "\t";
}

Databases
With all the description lines determined, they are added to $table line,
together with a tab character.
The SQ line type provides sequence header details for the SWISS-PROT entry.
sequence header in order to import it into the proteins table as a separate data
item. The if block starts by remembering the sequence header in a scalar called
$header. A second pattern match is then performed against the value in $header
to determine the first number, which is matched against the ''\d+'' pattern:
if ( /^SQ
(.+)/ )
{
my $header = $1;
$header =~ /(\d+)/;
$table_line = $table_line . $header . "\t" . $1 . "\t";
}
The sequence header (in $header) and the determined sequence length (in $1)
are then added to the $table line scalar, separated from each other by the
required tab character.
The actual data associated with the protein structure is in the sequence data
DT, DE and SQ). As with the DE line type, there can be more than one line of
data in the sequence. The strategy for determining the entire sequence is similar
to that used to determine the entire description. The sequence data is located
immediately before the end of the SWISS-PROT entry, which is indicated by a
double slash (//) at the start of a line on its own. The if block looks for this
pattern, and when it is found, it uses last to break out of the inner loop. Note
the use of the square brackets as delimiters around the ''//'' pattern, because the
forward-leaning slash character is the default pattern-matching delimiter:
if ( /^
(.+)/ )
{
my $sequence_lines = $1;
while ( <> )
{
if ( m[^//] )
{
last;
}
else
{
/^
(.+)/;
$sequence_lines = $sequence_lines . $1;
}

A Database Case Study: MER
}
$table_line = $table_line . $sequence_lines;
}
When all the sequence data lines are in the $sequence lines scalar, they are
added to the $table line scalar. As the sequence data is at the end of a row of
the line of data will be terminated by the newline character.
The final pattern match in get proteins checks for the end of entry double
slash. When it is found, the if block prints out the value of $table line with the
required newline. Once printed, the value of $table line is reset to the empty
string, in preparation for processing the next SWISS-PROT entry (if there is one):
if ( m[^//] )
{
print "$table_line\n";
$table_line = '';
}
}
When provided with the names of a collection of data files containing one or more
SWISS-PROT entries, the get proteins program converts all the entries in each
The line of data is then printed to standard output. Assume that a collection of
SWISS-PROT data files are named as follows:
acica_ADPT.swp.txt
serma_abdprt.swp.txt
shilf_seq_ACDP.swp.txt
the conversion on each entry and then writes the output to a data file called
proteins.input:
./get_proteins
*swp*
>
proteins.input
The ''>'' character on the command-line redirects the output away from standard
output and towards the named file.
Importing tab-delimited data into proteins
There now exists a collection of tab-delimited rows of data in proteins.input.
Importing this data into the proteins table is straightforward:
mysql
-u
bbp
-p
MER
mysql> load data local infile "proteins.input" into table proteins;
Query OK, 14 rows affected (0.07sec)
Records: 14
Deleted: 0, Skipped: 0, Warnings: 0

Databases
After logging-in to the MER database as the ''bbp'' user, a LOAD DATA query is
issued to import the data in the file proteins.input into the proteins table.
MySQL responds by stating that the query was OK, and indicates that 14 records
were affected. 14 rows of data have been successfully added to the proteins
seconds.
Working with the data in proteins
The SQL DML query, SELECT, allows data in a table to be displayed8. The basic
form of the SELECT query involves specifying the names of the columns to
display, together with the table name. Here is a SELECT query that displays the
accession number and sequence length values for all the rows in the proteins
table:
mysql> select accession_number, sequence_length
-> from proteins;
+------------------+-----------------+
| accession_number | sequence_length |
+------------------+-----------------+
| Q52109
|
561 |
| Q52110
|
121 |
| Q52107
|
91 |
| Q52106
|
116 |
| P08662
|
460 |
| P08664
|
212 |
| P08654
|
121 |
| P13113
|
91 |
| P13111
|
144 |
| P13112
|
116 |
| P08332
|
564 |
| P04337
|
60 |
| P20102
|
120 |
| P04129
|
91 |
+------------------+-----------------+
14 rows in set (0.06 sec)
The SELECT query extracts the columns from the proteins table and displays
the data in the form of a table. As expected, this new (temporary) table has two
columns and 14 rows of data. The word FROM has special meaning when used
with SELECT: it identifies the table against which to execute the query.
Note how this query is entered into the MySQL Monitor over two lines. If,
when entering a query, the Enter key is pressed, the MySQL Monitor prompts
for an additional line of input with the ''->'' symbol. Remember, the query is
through this section.

A Database Case Study: MER
not executed until the required semicolon is encountered. In this query, the
semicolon appears at the end of the second line. The MySQL Monitor treats the
two lines as one single query.
SELECT queries can be qualified in a number of ways9. The ORDER BY qualifier
sorts the results on the basis of a column name. In this next query, the results
from the query are sorted by accession number:
mysql> select accession_number, sequence_length
-> from proteins
-> order by accession_number;
+------------------+-----------------+
| accession_number | sequence_length |
+------------------+-----------------+
| P04129
|
91 |
| P04337
|
60 |
| P08332
|
564 |
| P08654
|
121 |
| P08662
|
460 |
| P08664
|
212 |
| P13111
|
144 |
| P13112
|
116 |
| P13113
|
91 |
| P20102
|
120 |
| Q52106
|
116 |
| Q52107
|
91 |
| Q52109
|
561 |
| Q52110
|
121 |
+------------------+-----------------+
14 rows in set (0.01 sec)
A further qualifier, WHERE, filters the results from the query on the basis of a
condition. In this next example query, only those results in which the length of
the sequence is greater than 200 are displayed:
mysql> select accession_number, sequence_length
-> from proteins
-> where sequence_length > 200
-> order by sequence_length;
+------------------+-----------------+
| accession_number | sequence_length |
+------------------+-----------------+
| P08664
|
212 |
| P08662
|
460 |
| Q52109
|
561 |
| P08332
|
564 |
+------------------+-----------------+
4 rows in set (0.04 sec)

Databases
And with this query, Question 1 from page 231 is answered: How many protein
is 4. Note that the results from this query are sorted by sequence length, as
opposed to accession number (as they were with the last query).
Adding another table to the MER database
More data is required to answer the rest of the questions on page 231. Another
table needs to be created in the MER database to accommodate this additional
entries.
The create dnas.sql text file contains a CREATE TABLE query that defines
the structure for a new table, called dnas:
create table dnas
(
accession_number varchar (8)
not null,
entry_name
varchar (9)
not null,
sequence_version varchar (16) not null,
last_date
date
not null,
description
text
not null,
sequence_header
varchar (75) not null,
sequence_length
int
not null,
sequence_data
text
not null
)
This table structure is not unlike that for the proteins table (on page 237).
However, it is different. The accession number in the dnas table can be 8
characters long, whereas the similarly named column in proteins is restricted
to a maximum of 6 characters. Also, the second and third columns in this table
hold data on the EMBL entries name and the version number, respectively. Recall
that columns 2 and 3 in the proteins table hold data on the mnemonic code and
species for a protein structure.
As with the creation of the proteins table, the create dnas.sql text file can
be fed to the MySQL Monitor to create the dnas table. The MySQL Monitor is then
used to issue a SHOW TABLES and DESCRIBE query to confirm that the dnas table
exists within the MER database, as follows:
mysql
-u
bbp
-p
MER
<
create_dnas.sql
mysql
-u
bbp
-p
MER
mysql> show tables;
+-----------------+
|
Tables_in_MER
|
+-----------------+
| dnas
|

A Database Case Study: MER
| proteins
|
+-----------------+
2 rows in set (0.00 sec)
mysql> describe dnas;
+------------------+-------------+------+-----+------------+-------+
| Field
| Type
| Null | Key | Default
| Extra |
+------------------+-------------+------+-----+------------+-------+
| accession_number | varchar(8)
|
|
|
|
|
| entry_name
| varchar(9)
|
|
|
|
|
| sequence_version | varchar(16) |
|
|
|
|
| last_date
| date
|
|
| 0000-00-00 |
|
| description
| text
|
|
|
|
|
| sequence_header
| varchar(75) |
|
|
|
|
| sequence_length
| int(11)
|
|
| 0
|
|
| sequence_data
| text
|
|
|
|
|
+------------------+-------------+------+-----+------------+-------+
8 rows in set (0.00 sec)
Preparing EMBL data for importation
The strategy for populating the dnas table with data is very similar to that used
with proteins. A program called get dnas (which is based on get proteins)
processes any number of EMBL entries and converts each entry into an appropri-
ately formatted tab-delimited line of data. Here is the get dnas program:
#! /usr/bin/perl -w
# get_dnas - given a list of EMBL files, extract data
# from them in preparation for importation into a database system.
#
# Note that the results produced are TAB-delimited.
BEGIN {
push @INC, "$ENV{'HOME'}/bbp/";
}
use UsefulUtils qw( biodb2mysql );
use strict;
my ( $table_line, $name );
while ( <> )
{
if ( /^ID
(.+?) / )
{
$name = $1;
}
if ( /^AC
(.+?);/ )
{

Databases
$table_line = $1 . "\t" . $name . "\t";
while ( <> )
{
last unless /^AC/;
}
}
if ( /^SV
(.+)/ )
{
$table_line = $table_line . $1 . "\t";
}
if ( /^DT/ )
{
my $date_line = $_;
while ( <> )
{
last unless /^DT/;
$date_line = $_;
}
$date_line =~ /^DT
(.+?) /;
$table_line = $table_line . biodb2mysql( $1 ) . "\t";
}
if ( /^DE
(.+)/ )
{
my $descr_lines = $1;
while ( <> )
{
last unless /^DE
(.+)/;
$descr_lines = $descr_lines . ' ' . $1
}
$table_line = $table_line . $descr_lines . "\t";
}
if ( /^SQ
(.+)/ )
{
my $header = $1;
$header =~ /(\d+)/;
$table_line = $table_line . $header . "\t" . $1 . "\t";
}
if ( /^
(.+?)\s+\d+/ )
{
my $sequence_lines = $1;
while ( <> )
{
if ( m[^//] )
{
last;

A Database Case Study: MER
}
else
{
/^
(.+?)\s+\d+$/;
$sequence_lines = $sequence_lines . ' ' . $1;
}
}
$table_line = $table_line . $sequence_lines;
}
if ( m[^//] )
{
print "$table_line\n";
$table_line = '';
}
}
get proteins, after all), let's examine the differences between this program and
the get proteins program.
The ID line in the EMBL entry is easy to process because there is no mnemonic
code nor species sub-parts to extract, as there was with the SWISS-PROT entry.
The identification of the EMBL entry is non-greedily matched against the line and
assigned to the $name scalar:
if ( /^ID
(.+?) / )
{
$name = $1;
}
processing of the AC line type.
The SV line is not found within SWISS-PROT entries, so the get dnas program
adds a pattern match to first find, and then extract, the EMBL sequence version
and add it to the tab-delimited line of data:
if ( /^SV
(.+)/ )
{
$table_line = $table_line . $1 . "\t";
}
Refer back to the sample EMBL entry on page 229, and note the format of the
sequence data. Unlike the sequence data within a SWISS-PROT entry, each line of
EMBL sequence data ends with a number. These numbers indicate the number of
these numbers in the dnas table, so the pattern match used within the if block
ensures that the numbers are not concatenated with the list of bases:

Databases
if ( /^
(.+?)\s+\d+/ )
{
my $sequence_lines = $1;
while ( <> )
{
if ( m[^//] )
{
last;
}
else
{
/^
(.+?)\s+\d+$/;
$sequence_lines = $sequence_lines . ' ' . $1;
}
}
$table_line = $table_line . $sequence_lines;
}
The pattern used to extract these bases are:
/^
(.+?)\s+\d+/
This matches five space characters at the start of a line, ''^'', followed by a
collection of one or more characters, ''.+?'', followed by one or more space
a line, ''$''. The collection of characters is remembered in the $1 scalar, then used
to construct the line of sequence data. When all the lines that contain sequence
data are exhausted, the list of bases is added to the tab-delimited line.
The rest of get dnas is as per the description of the get proteins program.
Let's assume a small series of EMBL entries is contained in a collection of data
files with the following names:
AF213017.EMBL.txt
J01730.embl.txt
M15049.embl.txt
M24940.embl.txt
the conversion on each entry, and then writes any output to a data file called
dnas.input:
./get_dnas
*EMBL*
*embl*
>
dnas.input
Remember that the ''>'' character on the command-line redirects the output away
from standard output and towards the named file.

A Database Case Study: MER
Importing tab-delimited data into dnas
There now exists a collection of tab-delimited rows of data in dnas.input.
Importing this data into the dnas table is accomplished by logging-in to the MER
database (using MySQL Monitor), and issuing the following LOAD DATA query:
mysql> load data local infile "dnas.input" into table dnas;
Query OK, 4 rows affected (0.01sec)
Records: 4
Deleted: 0, Skipped: 0, Warnings: 0
MySQL responds by stating that the query is OK, and indicates that 4 rows of
data were added to the dnas table.
Working with the data in dnas
Answering Question 2 from page 231 is easy, as the SQL DML query is based on
the query used to answer Question 1 from the last section. Here's the SELECT
query and the results returned from MySQL:
mysql> select accession_number, sequence_length
-> from dnas
-> where sequence_length > 4000
-> order by sequence_length;
+------------------+-----------------+
| accession_number | sequence_length |
+------------------+-----------------+
| J01730
|
5747 |
| AF213017
|
6838 |
+------------------+-----------------+
2 rows in set (0.00 sec)
Which answers the question: How many DNA sequences in the database are longer
than 4000 bases in length?
Answering Question 3, What's the largest DNA sequence in the database?, is
complicated by the fact that MySQL, version 3, does not yet support a technology
and use them as part of another. For instance, this SELECT query returns the
largest sequence length value from the dnas table:
select max( sequence_length ) from dnas;
It would be convenient to embed the result from this query into another SELECT
query, and then extract a list of columns, like this:
select accession_number, entry_name, sequence_length
from dnas
where sequence_length = ( select max( sequence_length ) from dnas );

Databases
That is, the sub-select determines the largest sequence length value, which is
then used to extract the accession number, entry name and sequence length
columns from the dnas table for the row that contains a value equal to the
maximum. This would be nice, if only MySQL supported this feature10.
Other than using another database system, this MySQL limitation can be
worked around using a number of techniques. One is to simply order the results
by sequence length, and arrange to display the list in descending order. That
way, the row (or rows) with the largest sequence length appear at the top of
the results. Here, again, is the query that answered Question 2, this time with
the ORDER BY clause qualified by the word DESC, which orders the results in
descending order:
mysql> select accession_number, sequence_length
-> from dnas
-> where sequence_length > 4000
-> order by sequence_length desc;
+------------------+-----------------+
| accession_number | sequence_length |
+------------------+-----------------+
| AF213017
|
6838 |
| J01730
|
5747 |
+------------------+-----------------+
2 rows in set (0.00 sec)
LIMIT query qualifier does just this:
mysql> select accession_number, entry_name, sequence_length
-> from dnas
-> order by sequence_length desc
-> limit 1;
+------------------+------------+-----------------+
| accession_number | entry_name | sequence_length |
+------------------+------------+-----------------+
| AF213017
| AF213017
|
6838 |
+------------------+------------+-----------------+
1 row in set (0.01 sec)
database?
Relating data in one table to that in another
The real power of a database system comes from its ability to relate the data in
one table to that in another. As they stand, the proteins and dnas tables are
plans call for the inclusion of sub-select.

A Database Case Study: MER
instance, they both contain a column called accession number, this alone does
not allow the tables to be related to each other. The AC values in proteins are
unique to the SWISS-PROT database, just as those in dnas are unique to the EMBL
database.
Both the SWISS-PROT and EMBL entries contain an optional DR line type, which
contains a list of database cross references for the entry. Here are the DR lines
from the sample SWISS-PROT entry (page 228):
DR
EMBL; AF213017; AAA19679.1; -.
DR
InterPro; IPR003457; Transprt_MerT.
DR
Pfam; PF02411; MerT; 1.
Note the EMBL line, which cross-references this SWISS-PROT entry to an identified
EMBL entry. It is this information that can be used to relate the data in the
proteins table to that in dnas. Here are the DR lines from the sample EMBL entry
(page 229):
DR
GOA; P08662; P08662.
DR
GOA; P13111; P13111.
DR
GOA; P13112; P13112.
DR
GOA; P13113; P13113.
DR
SWISS-PROT; P08662; MERA_SERMA.
DR
SWISS-PROT; P13111; MERR_SERMA.
DR
SWISS-PROT; P13112; MERT_SERMA.
DR
SWISS-PROT; P13113; MERP_SERMA.
Again, notice that there are DR lines that cross-reference this EMBL entry to a
relate the data in the dnas table to that in proteins.
Adding the crossrefs table to the MER database
The create crossrefs.sql text file contains a CREATE TABLE query that defines
the structure for a new table, called crossrefs:
create table crossrefs (
ac_protein varchar (6) not null,
ac_dna
varchar (8) not null
)
The crossrefs table contains two columns. The first, ac protein, holds the
accession number extracted from a SWISS-PROT entry, while the second, ac dna,
holds the accession number extracted from an EMBL entry. This table is added to
the MER database with the now familiar commands:

Databases
mysql
-u
bbp
-p
MER
<
create_crossrefs.sql
mysql
-u
bbp
-p
MER
mysql> show tables;
+-----------------+
|
Tables_in_MER
|
+-----------------+
| crossrefs
|
| dnas
|
| proteins
|
+-----------------+
3 rows in set (0.00 sec)
mysql> describe crossrefs;
+------------+------------+------+-----+---------+-------+
| Field
| Type
| Null | Key | Default | Extra |
+------------+------------+------+-----+---------+-------+
| ac_protein | varchar(6) |
|
|
|
|
| ac_dna
| varchar(8) |
|
|
|
|
+------------+------------+------+-----+---------+-------+
2 rows in set (0.00 sec)
The create crossrefs.sql text file is fed to the MySQL Monitor, then the
database is logged into by the ''bbp'' user. The SHOW TABLES query confirms that
the database now contains three tables, and a DESCRIBE query issued against the
crossrefs table provides details on the structure of crossrefs.
Preparing cross references for importation
The strategy for determining cross-reference data from both the SWISS-PROT
and EMBL entries is the same. Each entry is processed one line at a time in
order to determine the AC line type. When this is found, the accession number
is remembered in a scalar variable container called $ac. A pattern then matches
against the DR line type.
For SWISS-PROT entries that cross-reference the EMBL database, the DR line
number (stored in $ac), a tab character and the EMBL accession number (stored in
$1) are printed to standard output.
algorithm for any collection of SWISS-PROT entries:
#! /usr/bin/perl -w
# get_protein_crossrefs - given a list of SWISS-PROT files, extract
# data in preparation for importation into a database system.
# The AC number is extracted, together with any EMBL AC's.

A Database Case Study: MER
#
# Note that the results produced are TAB-delimited.
use strict;
my ( $ac );
while ( <> )
{
if ( /^AC
(.+?);/ )
{
$ac = $1;
while ( <> )
{
last unless /^AC/;
}
}
if ( /^DR
EMBL; (.+?); /)
{
print "$ac\t$1\n";
}
}
Similarly, for EMBL entries that cross-reference the SWISS-PROT database, the
DR line begins with ''DR SWISS-PROT;'', followed by the accession number of
the cross-referenced SWISS-PROT entry. If a match is found on this pattern, the
current SWISS-PROT accession number (stored in $1), a tab character and the
EMBL accession number (stored in $ac) are printed to standard output.
for any collection of EMBL entries:
#! /usr/bin/perl -w
# get_dna_crossrefs - given a list of EMBL files, extract data
# from them in preparation for importation into a database system.
# The AC number is extracted, together with any SWISS-PROT AC's.
#
# Note that the results produced are TAB-delimited.
use strict;
my ( $ac );
while ( <> )
{
if ( /^AC
(.+?);/ )
{
$ac = $1;

Databases
while ( <> )
{
last unless /^AC/;
}
}
if ( /^DR
SWISS-PROT; (.+?); / )
{
print "$1\t$ac\n";
}
}
per line, in SWISS-PROT, EMBL order.
from the same collection of SWISS-PROT and EMBL entries used earlier in this
chapter:
./get_protein_crossrefs
*swp*
>
protein_crossrefs
./get_dna_crossrefs
*embl*
*EMBL*
>
dna_crossrefs
Two lists of cross references now exist. It is possible to load each of these
lists into the crossrefs table. However, as there is a high likelihood that the
prudent to remove the duplicates before loading the data into the database.
Another small program, called unique crossrefs, does just this. Using a very
popular Perl programming idiom, it reads any number of cross references and
inserts them into a hash called %unique. The name part of %unique is set to
the cross-reference value, while the value part is set to 42 (for want of a better
value11). The unique crossrefs program ignores the value part of the hash, and
takes advantage of the fact that the name parts must be unique:
#! /usr/bin/perl -w
# unique_crossrefs - read the cross reference files produced by
# get_dna_crossrefs and get_protein_crossrefs and produce a unique
# list by removing duplicates.
use strict;
my %unique;
while ( <> )
{
chomp;
$unique{ $_ } = 42;
However, the use of 42 on this occasion may have something to do with Douglas Adams.

A Database Case Study: MER
}
foreach my $crossref ( keys %unique )
{
print "$crossref\n";
}
The cross references are read one line at a time and added to the hash. Note
the use of chomp to remove the newline character from the end of each line
of input. Once the list of cross references is exhausted, a foreach statement
extracts the name parts from the %unique hash using keys, then prints them
to standard output (one at a time). The following command-line takes the
data files produced by protein crossrefs and dna crossrefs and runs the
unique crossrefs program against them. The results are written to a new data
file, called unique.input:
./unique_crossrefs
protein_crossrefs
dna_crossrefs
>
unique.input
Importing tab-delimited data into crossrefs
Importing the unique.input data into the crossrefs table is accomplished by
logging-in to the MER database (using MySQL Monitor), and issuing the following
LOAD DATA query:
mysql> load data local infile "unique.input" into table crossrefs;
Query OK, 22 rows affected (0.04 sec)
Records: 22
Deleted: 0
Skipped: 0
Warnings: 0
A total of 22 distinct cross references now exist in the database.
Working with the data in crossrefs
A quick way to view all the data in a table is to use the wildcard version of
the SELECT query. Use this SELECT query to view every row and column in the
crossrefs table:
mysql> select * from crossrefs;
+------------+----------+
| ac_protein | ac_dna
|
+------------+----------+
| P04336
| J01730
|
| P08332
| J01730
|
| P08654
| M15049
|
| P20102
| X03405
|
| Q52107
| AF213017 |
| P03827
| J01730
|
| P13113
| M24940
|
| P04129
| J01730
|

Databases
| P13112
| M24940
|
| P04337
| J01730
|
| P04129
| K03089
|
| P08662
| M24940
|
| P08662
| M15049
|
| P13111
| M24940
|
| P08332
| K03089
|
| P20102
| L29404
|
| P03830
| J01730
|
| Q52109
| AF213017 |
| P20102
| J01730
|
| Q52106
| AF213017 |
| P04337
| K03089
|
| P08664
| M15049
|
+------------+----------+
22 rows in set (0.02 sec)
The crossrefs table provides the needed link to relate the proteins table
to dnas. Specifically, the SWISS-PROT accession number stored in the pro-
teins table can be related to the SWISS-PROT accession number in cross-
refs. The EMBL accession number cross-referenced with the same SWISS-PROT
accession number in crossrefs can be used to relate the EMBL accession
number in crossrefs with the EMBL accession number stored in the dnas
table.
Here's a SELECT query to extract data from the proteins and dnas tables on
the basis of the existence of a cross reference:
mysql> select proteins.sequence_header, dnas.sequence_header
-> from proteins, dnas, crossrefs
-> where proteins.accession_number = crossrefs.ac_protein
-> and dnas.accession_number = crossrefs.ac_dna
-> order by proteins.sequence_header;
The sequence header columns from both tables are explicitly identified by pre-
fixing each column name with its associated table name. Unlike the SELECT
queries from earlier, this query extracts its data from three tables: proteins,
dnas and crossrefs, and these tables are identified as part of the FROM
clause.
The WHERE qualifier relates the data in all three tables to each other. If the
SWISS-PROT accession number in crossrefs is identical to the SWISS-PROT
accession number in proteins, in addition to the EMBL accession number in the
same row in crossrefs being identical to that in dnas, a link can be established
between the protein structure and the DNA sequence.
The ORDER BY qualifier arranges to display the results sorted by SWISS-PROT
sequence header. The results from this query are shown in Figure 12.1 on
page 261.

A Database Case Study: MER
The cross-referenced sequence headers from the proteins and dnas tables.

Databases
A variation on the last SELECT query may produce more meaningful results.
This query extracts the code and species values from the proteins table,
together with any associated DNA entry name for all cross references:
mysql> select proteins.code, proteins.species, dnas.entry_name
-> from proteins, dnas, crossrefs
-> where proteins.accession_number = crossrefs.ac_protein
-> and dnas.accession_number = crossrefs.ac_dna;
+------+---------+------------+
| code | species | entry_name |
+------+---------+------------+
| MERA | SHIFL
| EC4
|
| MERD | SERMA
| PPMER
|
| MERP | ACICA
| AF213017
|
| MERP | SERMA
| PPMERR
|
| MERP | SHIFL
| EC4
|
| MERT | SERMA
| PPMERR
|
| MERC | SHIFL
| EC4
|
| MERA | SERMA
| PPMERR
|
| MERA | SERMA
| PPMER
|
| MERR | SERMA
| PPMERR
|
| MERA | ACICA
| AF213017
|
| MERD | SHIFL
| EC4
|
| MERT | ACICA
| AF213017
|
| MERB | SERMA
| PPMER
|
+------+---------+------------+
14 rows in set (0.05 sec)
by SWISS-PROT mnemonic code improves readability. Also, the ability to provide
more descriptive names for each column of results also helps. Here's a variation
on the last query that implements both improvements:
mysql> select
-> proteins.code as 'Protein Code',
-> proteins.species as 'Protein Species',
-> dnas.entry_name as 'DNA Entry Name'
-> from proteins, dnas, crossrefs
-> where proteins.accession_number = crossrefs.ac_protein
-> and dnas.accession_number = crossrefs.ac_dna
-> order by proteins.code;
+--------------+-----------------+----------------+
| Protein Code | Protein Species | DNA Entry Name |
+--------------+-----------------+----------------+
| MERA
| SERMA
| PPMERR
|
| MERA
| SERMA
| PPMER
|
| MERA
| ACICA
| AF213017
|
| MERA
| SHIFL
| EC4
|
| MERB
| SERMA
| PPMER
|
| MERC
| SHIFL
| EC4
|

A Database Case Study: MER
| MERD
| SERMA
| PPMER
|
| MERD
| SHIFL
| EC4
|
| MERP
| ACICA
| AF213017
|
| MERP
| SERMA
| PPMERR
|
| MERP
| SHIFL
| EC4
|
| MERR
| SERMA
| PPMERR
|
| MERT
| ACICA
| AF213017
|
| MERT
| SERMA
| PPMERR
|
+--------------+-----------------+----------------+
14 rows in set (0.08 sec)
The use of the ''as'' keyword allows for the renaming of each column in the results
table, and an appropriate ORDER BY qualifier sorts the results by SWISS-PROT
mnemonic code. And with that query, Question 4 is answered: Which protein
structures are cross-referenced with which DNA sequences?
Adding the citations table to the MER database
To answer Question 5, Which literature citations reference the results from the
previous question? (that is, Question 4), more data is required than currently
exists in the MER database. A new table, called citations, stores data on the
citation information extracted from a collection of SWISS-PROT and EMBL entries.
create table citations (
accession_number varchar (8) not null,
number
int
not null,
author
text
not null,
title
text
not null,
location
text
not null,
annotation
text
)
The citations table is populated with data from any reference lines that exist
in either type of entry. These are easily identified: simply look for a series of
lines that start with the RN line type. Let's refer to this series of lines as a
reference record. Here is the reference record from the sample SWISS-PROT entry
on page 228:
RN
[1]
RP
SEQUENCE FROM N.A.
RX
MEDLINE=94134837; PubMed=8302940;
RA
Kholodii G.Y., Lomovskaya O.L., Gorlenko Z.M., Mindlin S.Z.,
RA
Yurieva O.V., Nikiforov V.G.;
RT
"Molecular characterization of an aberrant mercury resistance
RT
transposable element from an environmental Acinetobacter strain.";
RL
Plasmid 30:303-308(1993).

Databases
And here is the reference record from the sample EMBL entry on page 229:
RN
[1]
RP
1-2923
RX
MEDLINE; 89327136.
RA
Nucifora G., Chu L., Silver S., Misra T.K.;
RT
"Mercury operon regulation by the merR gene of the organomercurial
RT
resistance system of plasmid pDU1358";
RL
J. Bacteriol. 171(8):4241-4247(1989).
XX
Notice how both reference records are similar in that each has the same sequence
matters slightly more complicated, the SWISS-PROT manual identifies a different
set of mandatory and optional line types for its reference records than does the
EMBL manual.
The citations table, as defined above, provides columns to hold the refer-
ence number (RN), author (RA), title (RT) and location (RL). The other columns
store an accession number (extracted from the AC line type) and an optional
annotation.
The usual sequence of commands is used to create the citations table, check
to see that the table has been added to the database (using SHOW TABLES) and
display the structure of the newly created table (using DESCRIBE):
mysql
-u
bbp
-p
MER
<
create_citations.sql
mysql
-u
bbp
-p
MER
mysql> show tables;
+---------------+
| Tables_in_MER |
+---------------+
| citations
|
| crossrefs
|
| dnas
|
| proteins
|
+---------------+
4 rows in set (0.00 sec)
mysql> describe citations;
+------------------+------------+------+-----+---------+-------+
| Field
| Type
| Null | Key | Default | Extra |
+------------------+------------+------+-----+---------+-------+
| accession_number | varchar(8) |
|
|
|
|
| number
| int(11)
|
|
| 0
|
|
| author
| text
|
|
|
|
|
| title
| text
|
|
|
|
|
| location
| text
|
|
|
|
|

A Database Case Study: MER
| annotation
| text
| YES
|
| NULL
|
|
+------------------+------------+------+-----+---------+-------+
6 rows in set (0.00 sec)
optional.
Preparing citation information for importation
The get citations program processes any collection of SWISS-PROT and EMBL
entries, extracting any found reference records. Both types of entry can contain
zero, one or more reference records, and the get citations program needs to
accommodate this. Additionally, the RT line type, which contains the reference
title, is - somewhat surprisingly - optional within SWISS-PROT entries, but not
within an EMBL entry. This also has to be taken into consideration. Here's the
entire get citations program:
#! /usr/bin/perl -w
# get_citations - given a list of SWISS-PROT and EMBL files, extract
# data in preparation for importation into a database system.
# Specifically, extract the RN citation information from the files.
#
# Note that the results produced are TAB-delimited.
use strict;
my ( $table_line, $ac, $title_lines );
while ( <> )
{
if ( /^AC
(.+?);/ )
{
$ac = $1;
while ( <> )
{
last unless /^AC/;
}
}
if ( /^RN
\[(\d+)\]/ )
{
print "$table_line\t\n" if defined $table_line;
$table_line = $ac . "\t" . $1 . "\t";
while ( <> )
{
if ( /^RA
(.+)/ )

Databases
{
my $author_lines = $1;
while ( <> )
{
last unless /^RA
(.+)/;
$author_lines = $author_lines . ' ' . $1
}
$table_line = $table_line . $author_lines . "\t";
}
if ( /^RT
(.+)/ )
{
$title_lines = $1;
while ( <> )
{
last unless /^RT
(.+)/;
$title_lines = $title_lines . ' ' . $1
}
$table_line = $table_line . $title_lines . "\t";
}
if ( /^RL
(.+)/ )
{
my $location_lines = $1;
if ( !defined( $title_lines ) )
{
$table_line = $table_line . '(no title)' . "\t";
}
$title_lines = undef;
while ( <> )
{
last unless /^RL
(.+)/;
$location_lines = $location_lines . ' ' . $1
}
$table_line = $table_line . $location_lines;
if ( /^RN
\[(\d+)\]/ )
{
print "$table_line\t\n" if defined $table_line;
$table_line = $ac . "\t" . $1 . "\t";
redo;
}
else
{
last;
}
}

A Database Case Study: MER
}
}
}
print "$table_line\t\n" if defined $table_line;
The accession number is extracted from the AC line type in the usual way, and
stored in the $ac scalar. A pattern match then looks for ''RN'' at the start of a line.
If this is not found, the entry has no reference records and the get citations
program ends, producing no results. This explains the use of the if defined
statement qualifier appended to each of the print statements. That is, if there's
no $table line to print, don't print it.
If the pattern is found, the program processes the reference record. Recall that
the first, second (and subsequent) reference records are positioned immediately
reference records are separated from each other by a XX line type. This helps
explain the inclusion of a pattern match for ''RN'' at the start of the line within
the inner loop, as follows:
if ( /^RN
\[(\d+)\]/ )
{
print "$table_line\t\n" if defined $table_line;
$table_line = $ac . "\t" . $1 . "\t";
redo;
}
else
{
last;
}
If another RN line type is encountered within the inner loop (that is, while already
processing a reference record), it is highly likely that a SWISS-PROT entry is
being processed. The if block prints the current $table line, starts another
$table line and then invokes Perl's redo subroutine. This causes the current
(inner) loop to restart without re-evaluating the loop condition. As the program
has determined that a new reference record is starting, and as the program has
thing to do at this stage.
If, having reached the end of a reference record and having read a line that
PROT file. Either way, the invocation of last within the else block ensures that
the inner loop ends.

Databases
the files in the current directory12. The results are written to a new data file,
called citations.input:
./get_citations
*
>
citations.input
Importing tab-delimited data into citations
Importing citations.input into the crossrefs table is accomplished by
logging-in to the MER database (using MySQL Monitor), and issuing the following
LOAD DATA query:
mysql> load data local infile "citations.input" into table citations;
Query OK, 34 rows affected (0.08 sec)
Records: 34
Deleted: 0
Skipped: 0
Warnings: 0
Thirty-four citations are now stored in the table.
Working with the data in citations
that contains a mix of SWISS-PROT and EMBL accession numbers. Specifically, the
accession number column in citations can be related to the similarly named
column in both proteins and dnas, as well as the ac protein and ac dna
columns in crossrefs.
reference the results from the previous question?:
mysql> select
-> proteins.code as 'Protein Code',
-> proteins.species as 'Protein Species',
-> dnas.entry_name as 'DNA Entry Name',
-> citations.location as 'Citation Location'
-> from proteins, dnas, crossrefs, citations
-> where proteins.accession_number = crossrefs.ac_protein
-> and dnas.accession_number = crossrefs.ac_dna
-> and dnas.accession_number = citations.accession_number
-> order by proteins.code;
understand. In essence, it is the same query that answered Question 4, with the
main difference being that the accession number column in the dnas table is
EMBL data files.

A Database Case Study: MER
also related to the accession number column in the citations table. The FROM
clause includes the citations table in its list, and the location column of
data (from citations) is included in the results for this query as the ''Citation
Location'' column.
The abridged results from this query are shown in Figure 12.2 on page 270.
Where to from Here
A lot of ground has been covered in this chapter. Despite this, there is much
more to databases - this chapter is merely an introduction. No consideration has
been given to important database topics such as primary/secondary keys, indices
and normalisation. Nevertheless, the simple technique described in this chapter
can be applied to many situations. The mechanism is as follows:
# Design the table structures.
# Prepare the data for importation.
# Import the data.
# Process the data.
In the next chapter, the emphasis shifts from interacting with MySQL manually
(using the MySQL Monitor) to interacting automatically with the Perl programming
language. However, before moving on, take a moment to consider one more
maxim.
Maxim 12.3 The SELECT query can do no harm.
All SELECT can do is extract data from a collection of database tables. SELECT
cannot be used to insert, delete, replace or update data, which has the effect
of making SELECT a relatively safe database query to work with. Readers are
encouraged to do just that: experiment with SELECT, safe in the knowledge that
it can do no harm.
The Maxims Repeated
Here's a list of the maxims introduced in this chapter.
# A little database design goes a long way.
# Understand the data before designing the tables.
# The SELECT query can do no harm.

Databases
The results of the citation cross reference between the proteins and dna tables.