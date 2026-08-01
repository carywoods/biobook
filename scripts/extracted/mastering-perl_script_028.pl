use strict;
use warnings;
use DBI;
use Carp;
# Class data and methods
{
   # A hash of all attributes with default values
   my %_attributes = (
       _rebase      => { },  # unused in this implementation
                             #    key   = restriction enzyme name
                             #    value = pairs of sites and regular
expressions

       _mysql       => '??', #  e.g. mysql => 'rebase:localhost',
       _dbh         => '',   # database handle from DBI->connect
       _bionetfile  => '??', # source of data from e.g. "bionet.212" file
   );
       
   # Return a list of all attributes
   sub _all_attributes {
           keys %_attributes;
   }
}
# The constructor method
# Called from class, e.g. $obj = Rebase->new( mysql => 'localhost:rebase' );
sub new {
   my ($class, %arg) = @_;
   # Create a new object
   my $self = bless {  }, $class;
   # Set the attributes for the provided arguments
   foreach my $attribute ($self->_all_attributes(  )) {
       # E.g. attribute = "_name",  argument = "name"
       my($argument) = ($attribute =~ /^_(.*)/);
       if (exists $arg{$argument}) {
           if($argument eq 'rebase') {
               croak "Cannot set attribute rebase";
           }
           $self->{$attribute} = $arg{$argument};
       }
   }
   # MySQL host:database string must be given as "mysql" argument
   unless($arg{mysql}) {
       croak("No MySQL host:database specified");
   }
   # Connect to the Rebase database
   my $user = 'tisdall';
   my $passwd = 'NOTmyPASSWORD';
   my $dbh;
   unless($dbh = DBI->connect("dbi:mysql:$arg{mysql}", $user, $passwd)) {
       carp "Cannot connect to MySQL database at $arg{dbmfile}";
       return;
   }
   $self->setDBhandle($dbh);
   # If "bionetfile" argument given, populate the database from the bionet
file
   if($arg{bionetfile}) {
       $self->parse_rebase(  );
   }
   return $self;
}
# For this simple class I have no AUTOLOAD or DESTROY
# No "set" mutators: all initialization done by way of "new" constructor
sub get_regular_expressions {
   my($self, $enzyme) = @_;

   my $dbh = $self->getDBhandle;
   my $sth = $dbh->prepare(
       'select Regex from REGEXES, ENZYMES where
        ENZYMES.EnzId = REGEXES.EnzId and ENZYMES.Enzyme=?'
   );
   $sth->execute($enzyme);
   my @regexes;
   while( my $row = $sth->fetchrow_arrayref) {
           push(@regexes, $$row[0]);
   }
   return @regexes;
}
sub getDBhandle {
   my($self) = @_;
   return $self->{_dbh};
}
sub setDBhandle {
   my($self, $dbh) = @_;
   return $self->{_dbh} = $dbh;
}
sub get_recognition_sites {
   my($self, $enzyme) = @_;
   my $dbh = $self->getDBhandle;
   my $sth = $dbh->prepare(
       'select Site from SITES, ENZYMES
        where ENZYMES.EnzId = SITES.EnzId and ENZYMES.Enzyme=?'
   );
   $sth->execute($enzyme);
   my @sites;
   while( my $row = $sth->fetchrow_arrayref) {
           push(@sites, $$row[0]);
   }
   return @sites;
}
sub get_bionetfile {
   my($self) = @_;
   return $self->{_bionetfile};
}
sub parse_rebase {
   my($self) = @_;
   # handles multiple definition lines for an enzyme name
   # also handles alternate enzyme names on a line
   # Get database handle
   my $dbh = $self->getDBhandle(  );
   # Delete existing tables, recreate them
   # Prepare statement handles with "bind" variables and autoincrement
   # ENZYMES table
   my $drop = $dbh->prepare('drop table if exists ENZYMES');

   $drop->execute(  );
   my $create = $dbh->prepare(
       "CREATE TABLE ENZYMES ( EnzId int(11) NOT NULL auto_increment default
'0',
        Enzyme varchar(255) NOT NULL default '', PRIMARY KEY  (EnzId))
TYPE=MyISAM"
   );
   $create->execute(  );
   # Prepare filehandles outside of "while" loop
   my $enzymes_select = $dbh->prepare(
       'select EnzId from ENZYMES where Enzyme=?'
   );
   my $enzymes_insert =  $dbh->prepare(
       'insert ENZYMES ( EnzId, Enzyme ) values ( NULL, ? )'
   ); 
   # SITES table
   $drop = $dbh->prepare('drop table if exists SITES');
   $drop->execute(  );
   $create = $dbh->prepare(
       "CREATE TABLE SITES ( SiteId int(11) NOT NULL auto_increment default
'0',
        EnzId int(11) NOT NULL default '0', Site varchar(255) NOT NULL
default '',
        PRIMARY KEY  (SiteId)) TYPE=MyISAM"
   );
   $create->execute(  );
   # Prepare filehandles outside of "while" loop
   my $sites_insert = $dbh->prepare(
       'insert SITES ( SiteId, EnzId, Site ) values ( NULL, ?, ? )'
   );
   my $sites_select = $dbh->prepare(
       'select EnzId, Site from SITES where EnzId=? and Site=?'
   );
   my $sitesrevcom_select = $dbh->prepare(
       'select EnzId, Site from SITES where EnzId=? and Site=?'
   );
   # REGEXES table
   $drop = $dbh->prepare('drop table if exists REGEXES');
   $drop->execute(  );
   $create = $dbh->prepare(
       "CREATE TABLE REGEXES ( RegexId int(11) NOT NULL auto_increment
default '0',
        EnzId int(11) NOT NULL default '0', Regex varchar(255) NOT NULL
default '',
        PRIMARY KEY  (RegexId)) TYPE=MyISAM"
   );
   $create->execute(  );
   # Prepare filehandles outside of "while" loop
   my $regexes_insert = $dbh->prepare(
       'insert REGEXES ( RegexId, EnzId, Regex ) values ( NULL, ?, ? )'
   );
   my $lastid =  $dbh->prepare('select LAST_INSERT_ID(  ) as pk');
   # Read in the bionet(Rebase) file
   unless(open(BIONETFH, $self->get_bionetfile)) {
       croak("Cannot open bionet file " . $self->get_bionetfile);
   }
   while(<BIONETFH>) {

       my @names = (  );
       # Discard header lines
       ( 1 .. /Rich Roberts/ ) and next;
       # Discard blank lines
       /^\s*$/ and next;
   
       # Split the two (or three if includes parenthesized name) fields
       my @fields = split( " ", $_);
       # Get and store the recognition site
       my $site = pop @fields;
       # For the purposes of this exercise, I'll ignore cut sites (^).
       # This is not something you'd want to do in general, however!
       $site =~ s/\^//g;
       # Get and store the name and the recognition site.
       # Add alternate (parenthesized) names
       # from the middle field, if any
       foreach my $name (@fields) {
           if($name =~ /\(.*\)/) {
               $name =~ s/\((.*)\)/$1/;
           }
           push @names, $name;
       }
       # Store the data, avoiding duplicates (ignoring ^ cut sites)
       # and ignoring reverse complements
       foreach my $name (@names) {
           my $pk;
           my $row;
           # if enzyme exists
           $enzymes_select->execute($name);
           if($row = $enzymes_select->fetchrow_arrayref) {
                   # get its "pk"
               $pk = $$row[0];
           }else{
               # Add new enzyme definition
               $enzymes_insert->execute($name);
               # Get last autoincremented primary id
               $lastid->execute(  );
               my $pkhash = $lastid->fetchrow_hashref;
               $pk = $pkhash->{pk};
           }
           # if pk,site exist go to top of loop
           $sites_select->execute($pk, $site);
           if($row = $sites_select->fetchrow_arrayref) {
               next;
           }
           # and if pk,revcomIUB(site) exist go to top of loop
           $sitesrevcom_select->execute($pk, revcomIUB($site));
           if($row = $sitesrevcom_select->fetchrow_arrayref) {
               next;
           }
           # Add new site definition
           #  since neither pk,site nor

           #  pk,revcomIUB(site) exists.
           $sites_insert->execute($pk, $site);
           # Add new regex definition
           $regexes_insert->execute($pk, IUB_to_regexp($site));
       }
   }
   return 1;
}
1;
=head1 RebaseDB
Rebase: A simple interface to recognition sites and translations of them into
       regular expressions, from the Restriction Enzyme Database (Rebase)
=head1 Synopsis
   use RebaseDB;
   my $rebase = RebaseDB->new(
       mysql => 'rebase:localhost',
       bionetfile => 'bionet.212'
   );
   my $enzyme = 'EcoRI';
   print "Looking up restriction enzyme $enzyme\n";
   my @sites = $rebase->get_recognition_sites($enzyme);
   print "Sites are @sites\n";
   my @res = $rebase->get_regular_expressions($enzyme);
   print "Regular expressions are @res\n";
   my $enzyme = 'HindIII';
   print "Looking up restriction enzyme $enzyme\n";
   my @sites = $rebase->get_recognition_sites($enzyme);
   print "Sites are @sites\n";
   my @res = $rebase->get_regular_expressions($enzyme);
   print "Regular expressions are @res\n";
   print "Rebase bionet file is ", $rebase->get_bionetfile, "\n";
=head1 AUTHOR
James Tisdall
=head1 COPYRIGHT
Copyright (c) 2003, James Tisdall
=cut
slightly altered.

   use lib "/home/tisdall/MasteringPerlBio/development/lib";
   
   use RebaseDB;
   my $rebase = RebaseDB->new(
       mysql => 'rebase:localhost',
       bionetfile => 'bionet.212'
   );
   my $enzyme = 'EcoRI';
   print "Looking up restriction enzyme $enzyme\n";
   my @sites = $rebase->get_recognition_sites($enzyme);
   print "Sites are @sites\n";
   my @res = $rebase->get_regular_expressions($enzyme);
   print "Regular expressions are @res\n";
   my $enzyme = 'HindIII';
   print "Looking up restriction enzyme $enzyme\n";
   my @sites = $rebase->get_recognition_sites($enzyme);
   print "Sites are @sites\n";
   my @res = $rebase->get_regular_expressions($enzyme);
   print "Regular expressions are @res\n";
   print "Rebase bionet file is ", $rebase->get_bionetfile, "\n";
Here's the output of testRebaseDB:
Looking up restriction enzyme EcoRI
Sites are GAATTC
Regular expressions are GAATTC
Looking up restriction enzyme HindIII
Sites are AAGCTT
Regular expressions are AAGCTT
Rebase bionet file is bionet.212
database interface.
For starters, the %_attributes hash has changed to reflect the new relational database
database; in the absence of this argument, the program attempts to use a previously loaded
database.
the user's computer (localhost if the user is running the program on the same computer the
database is served from). _dbh holds the DBI object returned from the DBI->connect call.
bit differently, of course, because this version of the class has different arguments coming in.
much better behavior than just dying. If this were a web script, for instance, you might want
to keep running so you can return more input from the user in case of failure.
In case of success, the DBI->connect object reference is saved in the attribute reserved for

this purpose, $self->{_dbh}. (dbh stands for "data base handle".) Elsewhere in the module
_dbh.
After retrieving as $dbh the object that points to the database, the method sends several SQL
tables anew (and empty).
are used repeatedly in the while loop that follows, and the program saves time by having the
SQL statements prepared just once before the loop.
the use of autoincrementing on the ID field of each table. This option, applicable only to
single-field keys that serve as the primary key for a table, has the effect of always picking the
next value for the field, and is perfect for the unique ID field I usually want in a table as the
and prepares to read it within a while loop. The beginning of this loop is unchanged from the
previous version Rebase.pm because it discards the file header and blank lines and extracts
the names of the restriction enzymes and the associated recognition sites.
First, the program checks to see if there is already a definition for the enzyme entered in the
database; if so, it just retrieves its unique ID, the primary key $pk. If the enzyme hasn't been
entered, it is now, and the ID that is automatically created for it is saved.
Next, the program checks if that primary key ID and site are already paired in the SITES table;
if so, it goes back to the top of the while loop.
Again, the program checks if that primary key ID and the reverse complement of the site are
already paired in the SITES table; if so, it goes back to the top of the while loop.
However, if the ID and the site are still unknown, they are entered into the SITES table, and
table.
That wraps it up for the parse_rebase method. Because of all the database interactions, this
is a pretty slow bit of code (see the exercises).
statement in each of these methods is an example of a join of two tables:
select Regex from REGEXES, ENZYMES
where ENZYMES.EnzId = REGEXES.EnzId and ENZYMES.Enzyme=?;
(This is one SQL statement.) The statement asks for the regular expressions from the
ENZYMES table.
That's the end of my discussion of the RebaseDB.pm class module. See the exercises for
suggestions on how to improve this module.

[
Tea
m
LiB ]

6.9 Additional Topics
in database work:

with your DBMS carefully, and look at several examples. Tutorial books are also
available for most popular DBMS.

belong together. For example, you may enter a new gene into your database by
now provide support for this view of database updates.


of entry when a user is filling out a form for instance. MySQL is just now starting to
support them; major DBMS such as Oracle have had them for a long time. They tend
the difficulty of migrating to a different DBMS if that becomes necessary in the future.

some acceptance. You may come across them on the job, although their use is much
more limited than the standard relational model.

6.10 Resources
The literature on databases is very large, and so the documentation for your particular RDMS
is essential. For this book, I use MySQL, but many others are suitable.
Here are a handful of basic textbooks:

Database Systems: A Practical Approach to Design, Implementation, and
Management, Thomas Connolly and Carolyn Begg (Pearson Addison Wesley)

A First Course in Database Systems, Jeffrey Ullman (Prentice Hall)

An Introduction to Database Systems, C.J. Date (Pearson Addison Wesley)

MySQL, Paul DuBois (SAMS)

The MySQL Cookbook, Paul DuBois (O'Reilly & Associates)

MySQL and Perl for the Web, Paul DuBois (SAMS)

Programming the Perl DBI, Alligator Descartes and Tim Bunce (O'Reilly)

6.11 Exercises
Exercise 6.1
What's the difference between a database and a database management system?
What's the difference between MySQL and Oracle?
Exercise 6.2
relational database? Its strengths?
Exercise 6.3
Is my homologs database, which was placed into second normal form, also in third
normal form?
Exercise 6.4
Write a program that checks if a relation is in second normal form.
Exercise 6.5
RebaseDB.pm is written to specify a MySQL database. Rewrite the module so it can
specify another relational database supported by DBI.
Exercise 6.6
The parse_rebase method of the RebaseDB.pm module uses several database queries
per input line as part of the logic of avoiding duplicate entries for palindromes and
reverse complements. Compare it with the parse_rebase method in Rebase.pm.
Make a new parse_rebase method that works for both DBM and DBI database
storage and will improve the efficiency of the DBI method by minimizing database
queries.
Exercise 6.7
RebaseDB.pm is a port of the earlier version Rebase.pm that used the DBM hash
depending on the arguments passed to the new method.
Exercise 6.8
Compare MySQL with some other relational database management system; include
such management issues as cost of purchase, cost of maintenance, availability of
skilled personnel, stability of vendor in the marketplace, and customer support.
Exercise 6.9
to improve the quality and reduce the number of possible relational designs?
Exercise 6.10
Name two bioinformatics problems that are ill-served by the data structures of a
relational database.
Exercise 6.11
Implement a relational database that supports a project in your wet lab.

This is as true for bioinformaticians as it is for other programmers.
specialize early; perhaps you work in analyzing algorithms for representing gene cascades,
while web programming is someone else's responsibility.
certainly true in biology, where it is typical for laboratories to provide programs and access to
invite readers to visit web sites for supporting information), and valuable research tools can
be widely disseminated.
names and returns a restriction map.
Along with the remarkable growth in use of the Web and the Internet have come an equal
proliferation of languages, systems, and tools for web programming. There are now a variety
of choices in how a programmer can create interactive web pages.
We will use one such system that employs the Perl language. To make the web pages
interactive to enable users to type in queries and get responses we'll use the popular CGI.pm
Perl module that's shipped with all recent versions of Perl. CGI stands for the Common
various reasons (such as a user asking for a restriction map) as opposed to static, unchanging
web programming, despite the many alternatives now available.
Because bioinformatics programmers need at least a basic working knowledge of web
chapters.
web programming, feel free to skip ahead.

7.1 How the Web Works
The Internet is short for "interconnected networks." It is a set of conventions protocols with
widely used.
software to use it was in the form of programs called web browsers and web servers. Web
programs that accept requests from web browsers and send results back to them for display;
were growing, which made the new web protocol even more widespread.
results from servers and display them for the user. This type of architecture is called a 
earth.
In order for this scheme to work, the web browser has to be able to send its request to the
browser screen.
double-stranded RNA. How does this work, exactly?
for a specific article, which is then returned to your computer and displayed by your web
browser.
programming.

URL. The Internet (to which you must be connected for this to work, of course) takes the
are configured for this task, resolves the URL into an Internet address (IP address), which is
translated by routing tables into the numeric IP address.
The details of this are not important; if you know it, you can also just type in the numeric
correct actual Internet address. Then, if the New York Times changes its main computer, or
decides to move to Paris,
[1] all that needs to be done is for the routing tables to be updated
[1] The Paris Review moved from Paris to New York, after all.
A URL can have several parts:

It begins with a scheme, which is "http" in this case and specifies the protocol for the
request. "http" is the most common scheme; others include "https" for increased
security, "ftp" for file transfer protocol, and so on.

A colon and two forward slashes (://) separates the scheme from the hostname,
Internet; it gives the address of the computer with which you actually want to
communicate.

URL, such as a particular location on the server's computer, a port number, some
the browser is requesting.
For instance, say you want to use the web page the reporters for the New York Times
use to organize their list of helpful web sites. You'd type in 
http://www.nytimes.com/navigator. Now, following the hostname is the additional
information /navigator. This is a pathname for the particular web page you're
Sometimes it is longer, such as 
http://www.nytimes.com/library/tech/reference/cynavi.html, and includes several

arguments or queries are separated by question marks and give desired values to
parameters. A typical example might be 
http://www.mycomputer.com/cgi/rebase.cgi?enzyme=EcoRI?enzyme=HinDIII. This
requests a web page from the web server on the computer www.mycomputer.com.
The web page to be returned is generated on the fly by the CGI script on that
two enzymes (which the script will presumably use to formulate its reply), EcoRI and
HinDIII.
example, if you had a web page saved on your computer in the file 
running on the same computer: file:/home/tisdall/arabidopsis.html.
