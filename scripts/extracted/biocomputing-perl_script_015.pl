use strict;
use DBI;
my @drivers = DBI->available_drivers;
foreach my $driver ( @drivers )
{
print "Driver: $driver installed.\n";
}
After enabling strictness, the check drivers program uses the DBI module. A
call is then made to the available drivers subroutine included with the DBI
module. This returns a list of installed database drivers, which are assigned to
an array called @drivers. This array is then iterated over using foreach to
computer5:
Driver: ExampleP installed.
Driver: Pg installed.
Driver: Proxy installed.
Driver: mysql installed.
The first three drivers are included with DBI. The final driver, referred to as
mysql, is the DBD::mysql driver. So, Paul's database programming environment
is ready to go!
13.4
Programming Databases with DBI
Let's start with a simple example. A program, called show tables, connects to
the MER database (created during the last chapter) and determines the list of
tables in the database. Obviously, this can easily be achieved using the MySQL
Monitor, as it is just a matter of logging in to MySQL, using the MER database
and issuing a SHOW TABLES query, effectively negating the need for a custom
program. But bear with us, as all this example is designed to do is get things
going. Here is the entire show tables program:
#! /usr/bin/perl -w
# show_tables - list the tables within the MER database.
#
Uses "DBI::dump_results" to display results.
use strict;
version 2.1021 of DBD::mysql.