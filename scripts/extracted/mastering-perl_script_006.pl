#!/usr/bin/perl
use strict;
use warnings;
my $flag = 0;
my $table;
my @table;
my @fieldnames;
my @fields;
while(<>) {
   if(/^\s*$/) {
       # skip blank lines
       ;
   }elsif(/^TABLE\t(\w+)/) {
       # output previous table
       print(@table) if $flag;
       $flag = 1;
       # begin new table
       @table = (  );
       $table = $1;
       push(@table, "\nTable is $table\n");
   } elsif($flag =  = 1) {
       @fieldnames = split;
       $flag = 2;
       push(@table, "Fields are ", join("|", @fieldnames), "\n");
   } elsif($flag =  = 2) {
       @fields = split;
       push(@table, join("|", @fields) . "\n");
   }
}
# output last table
print @table;
As you see, this first version of the program uses the $flag variable to keep track of what

up as whitespace), the program outputs the previously read table (if $flag indicates there
was one). It then saves the next word as the table's name, sets the $flag to 1, and
prepares some output in the array @table.
Otherwise, if the $flag variable is set to 1, the program knows it's on the second line of a
table (remember, this program is specially written for the input file format I gave previously).
them to the @table output array.
Finally, if the $flag variable is set to 2, the program knows it's reading rows of the table; it
reformats them and adds them to the @table output array.
When all the input is done, and the while loop finishes, there will be the last table's
reformatted output ready to be printed from the @table output array.
If I call this program homologs.getdata and give it my data file homologs.tabs like so:
% perl homologs.getdata homologs.tabs
I get the following output:
Table is ORGANISM
Fields are OrgId|Organism
1|human
2|worm
3|mouse
Table is GENES
Fields are GeneId|Gene|Date
118|aging|1984-07-13
9223|wrinkle|1987-08-15
273|hairy|1990-09-30
Table is VARIANTS
Fields are VarId|OrgId|GeneId
1|1|118
2|2|118
3|1|9223
4|3|9223
5|3|273
Notice that all I've really done here is read in the data and print it out in a slightly different
with an actual database.
the MySQL database that will populate the MySQL database with the read-in data.
#!/usr/bin/perl
use strict;
use warnings;
# Make connection with MySQL database

use DBI;
my $database = 'homologs';
my $server   = 'localhost';
my $user     = 'tisdall';
my $passwd   = 'NOTmyPASSWORD';
my $homologs = DBI->connect("dbi:mysql:$database:$server", $user, $passwd);
# prepare an SQL statement
my $query    = "show tables";
my $sql      = $homologs->prepare($query);
# execute an SQL statement
$sql->execute(  );
# retrieve and print results
while (my $row = $sql->fetchrow_arrayref) {
   print join("\t", @$row), "\n";
}
# Break connection with MySQL database
$homologs->disconnect;
exit;
Here's the result of running this program:
GENES
ORGANISM
VARIANTS
useful detail.
After the obligatory use DBI; that loads the DBI module, I declare some variables to hold the
happens here:
my $homologs = DBI->connect("dbi:mysql:$database:$server", $user, $passwd);
another computer) as the user with the given password. mysql is specified; if you are using
DBI new method that creates (and initializes) a DBI object.
$homologs.
object, which I call $sql here. This statement object $sql then calls its own execute method
which actually does the job of sending the SQL to the database.
The actual SQL here is a very simple one. You've already seen that DBI->connect specifies
tables simply asks for a list of the names of the tables that are defined in that database.

value in $row points to the array of fields in that row. Here, I simply separate the fields with
tab characters with the help of the Perl join function on the dereferenced array @$row and
print the row with a newline.
sometimes possible to open a number of connections and eventually tax the MySQL DBMS to
the point where it has to refuse any more connect requests. Especially if you have an active
each connect.
try to install and use the DBI module. If it works, you're in business. If not, you have to
can help is to add an additional argument to the connect call that asks for more error
reporting, like so:
my $homologs = DBI->connect(
       "dbi:mysql:$database:$server", $user, $passwd, {RaiseError=>1}
);
This terminates the program with extra error messages if the connect call fails; this is usually
where things go wrong when you first try to use this software. (See the documentation for
site.
it over: most of it will be familiar from previous programs in this chapter.
#!/usr/bin/perl
use strict;
use warnings;
# Make connection with MySQL database
use DBI;
my $database = 'homologs';
my $server   = 'localhost';
my $user     = 'tisdall';
my $passwd   = 'NOTmyPASSWORD';
my $homologs = DBI->connect("dbi:mysql:$database:$server", $user, $passwd);
my $sqlinit  = $homologs->prepare("show tables");
$sqlinit->execute(  );
while (my $row = $sqlinit->fetchrow_arrayref) {
       print join("\t", @$row), "\n";
}
my $flag = 0;

my $table;
my @tables;
my $sql;
while(<>) {
   # skip blank lines
   if(/^\s*$/) {
       next;
   # begin new table
   }elsif(/^TABLE\t(\w+)/) {
       $flag = 1;
       $table = $1;
       push(@tables, $table);
       # Delete all rows in database table
       my $droprows = $homologs->prepare("delete from $table");
       $droprows->execute(  );
   # get fieldnames, prepare SQL statement
   } elsif($flag =  = 1) {
       $flag = 2;
       my @fieldnames = split;
       my $query = "insert into  $table ("
                    . join(",", @fieldnames)
                    . ") values ("
                    . "?, " x (@fieldnames-1)
                    . "?)";
       $sql = $homologs->prepare($query);
   # get row, execute SQL statement
   } elsif($flag =  = 2) {
       my @fields = split;
       $sql->execute( @fields);
   }
}
# Check if tables were updated
foreach my $table (@tables) {
       my $query = "select * from $table";
       my $sql = $homologs->prepare($query);
       $sql->execute(  );
       while (my $row = $sql->fetchrow_arrayref) {
           print join("\t", @$row), "\n";
       }
}
# Break connection with MySQL database
$homologs->disconnect;
exit;
same file used previously with the homologs.getdata program):
% perl homologs.load homologs.tabs
This is the output of the program:
GENES
ORGANISM
VARIANTS
