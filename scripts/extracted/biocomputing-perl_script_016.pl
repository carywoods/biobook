use DBI qw( :utils );
use constant DATABASE => "DBI:mysql:MER";
use constant DB_USER =>
"bbp";
use constant DB_PASS =>
"passwordhere";
my $dbh = DBI->connect( DATABASE, DB_USER, DB_PASS )
or die "Connect failed: ", $DBI::errstr, ".\n";
my $sql = "show tables";
my $sth = $dbh->prepare( $sql );
$sth->execute;
print dump_results( $sth ), "\n";
$sth->finish;
$dbh->disconnect;
Let's take a look at what's going on.
After the usual first line, a comment and the switching on of strictness, the
DBI module is used. Note the inclusion of the '':utils'' tag, which brings in a
collection of DBI database utility routines. Three constants are defined:
DATABASE - Identifies the data source to use. In show tables, the data source is
identified as DBI, the mysql driver, and the MER database.
DB USER - Identifies the username to use when connecting to the data source.
DB PASS - Identifies the password to use when authenticating to the data source.
An invocation of the connect subroutine (included with DBI) establishes a
database connection (or session) between the show tables program and MySQL:
my $dbh = DBI->connect( DATABASE, DB_USER, DB_PASS )
or die "Connect failed: ", $DBI::errstr, ".\n";
Note the specification of the three constants as parameters to connect.
If the connection cannot be established, connect returns undef and the
show tables program dies with an appropriate error message, which includes
a message from DBI (included in the $DBI::errstr scalar). If the connection
succeeds, connect returns a database handle, which is assigned to the $dbh
scalar. Database handles have specific DBI functionality associated with them.
The functionality is accessed through subroutine calls6.
and subroutine mean the same thing.

Databases and Perl
Bearing in mind that it is always a good idea to use good, descriptive names for
variables, why use $dbh instead of the more descriptive $database handle? In
this case, the earlier maxim is considered, but ignored, because of the convention
within the DBI programming community to use specifically named variables
for certain purposes. When established conventions exist within a programming
community, it is often better to follow them since nearly ever published work
on DBI uses $dbh as the database handle variable name. Another example of a
standard DBI variable name is $sth, which is used with statement handles.
Maxim 13.2 Be sure to adhere to any established naming conventions
within a programming community.
With a connection established to the database, the show tables program assigns
the SQL query to a scalar called $sql. This scalar is then used in a call to the
database handle's prepare subroutine that gets the SQL query ready for use.
case with the MySQL Monitor) is typically not required when working with DBI.
The prepared SQL query is assigned to a statement handle called $sth.
As with database handles, statement handles also have functionality associated
with them (in the form of invokable subroutines). The execute subroutine takes
the prepared SQL query and asks the database system to execute it. Any results
are returned to the show tables program and stored within the statement handle
identified by $sth.
To access the results returned from the database, the show tables program
invokes the DBI utility dump results, made available to the program as a result
of the :utils tag. The dump results subroutine displays the results of the
executed query in a relatively raw, unformatted way.
The program concludes by calling the finish subroutine on the statement
handle, which tells the database system that the query session is over, and
disconnects from the database by calling disconnect on the database handle.
Use the following command-lines to turn the show tables program into an
executable, then invoke it:
chmod
+x
show_tables
./show_tables
'citations'
'crossrefs'
'dnas'
'proteins'
4 rows