use strict;
use warnings;
use Carp;
use DB_File;
# Class data and methods
{
   # A hash of all attributes with default values
   my %_attributes = (
       _rebase      => { },
            #    key   = restriction enzyme name
            #    value = space-separated string of sites => regular
expressions
       _bionetfile  => '??',
       _dbmfile     => '??',
       _mode        => 0444,
   );
   # Return a list of all attributes
   sub _all_attributes {
       keys %_attributes;
   }
   # Return the value of an attribute
   sub _attribute_value {
       my($self,$attribute) = @_;
       $_attributes{$attribute};
   }
}
instance, I've tossed the code that keeps count of all objects. Why? Because it's unlikely that
more than one of these objects will be necessary in a program: so why bother?
Notice that the list of attributes is short:
_rebase
A hash that will be populated to provide the lookup, with enzyme names for keys, and
recognition sites (and their translation to regular expressions) for values. (Make sure
you see how in the hash %_attributes the value of the key _rebase is itself an
anonymous hash.)
_bionetfile
The name of the datafile from the Rebase distribution. In my examples, I use the
version numbered bionet.212, and by the time you read this book, more recent

versions will be available (you can get bionet.212 from this book's web site).
_dbmfile
The DBM filename that resides on disk and stores the data in the hash _rebase.
[1]
information, see O'Reilly's Programming Perl, the documentation for the DB_File module, and the
documentation for the dbmopen and tie functions.
_mode
This is important for security purposes.
recourse to the use of AUTOLOAD to define various accessors and mutators, as seen in
previous chapters.
Here's how a Rebase object is created and initialized:
# The constructor method
# Called from class, e.g. $obj = Rebase->new( dbmfile => 'DBMFILE' );
sub new {
   my ($class, %arg) = @_;
   # Create a new object
   my $self = bless {  }, $class;
   # DBM file must be given as "dbmfile" argument
   unless($arg{dbmfile}) {
       croak("No dbm file specified");
   }
   # Set the attributes for the provided arguments
   foreach my $attribute ($self->_all_attributes(  )) {
       # E.g. attribute = "_name",  argument = "name"
       my($argument) = ($attribute =~ /^_(.*)/);
       # Initialize to defaults
       $self->{$attribute} = $self->_attribute_value($attribute);
       # Override defaults with arguments
       if (exists $arg{$argument}) {
           if($argument eq 'rebase') {
               croak "Cannot set attribute rebase";
           }
           $self->{$attribute} = $arg{$argument};
       }
   }
   # Open or create the DBM file
   unless(tie %{$self->{_rebase}}, 'DB_File', $arg{dbmfile}, O_RDWR|O_CREAT,
$self->
{_mode}, $DB_HASH) {
       my $permissions = sprintf "%lo", $self->{_mode};
       croak "Cannot open DBM file $arg{dbmfile} with mode $permissions";
   }
   # If "bionetfile" argument given, calculate the hash from the bionet file

   if($arg{bionetfile}) {
       # Empty the hash
       %{$self->{_rebase}} = (  );
       # Recalculate the hash
       $self->parse_rebase;
   }
   return $self;
}
# For this simple class I have no AUTOLOAD or DESTROY
# No get_rebase method, I don't want to pass around a huge hash
# No "set" mutators: all initialization done by way of "new" constructor
parses the bionet file to create the _rebase hash.
As the comments indicate, my class is so simple I've even decided to do away with AUTOLOAD
and DESTROY, and I've dispensed with the _set mutators as well.
Now, let's continue by looking at the methods for the Rebase class. Given an enzyme, the
expressions.
How do these two methods work? One method returns all recognition sites for an enzyme as
_rebase hash. The value for each enzyme in the _rebase hash is a space-separated string
expressions. This list is then assigned to the hash %sites to populate it with keys as
recognition sites (keys) or regular expressions (values).
that are set to specific filenames or mode strings when the object was created:
sub get_regular_expressions {
   my($self, $enzyme) = @_;
   my(%sites) = split(' ', $self->{_rebase}{$enzyme});
   # May have duplicate values
   return values %sites;
}
sub get_recognition_sites {
   my($self, $enzyme) = @_;
   my(%sites) = split(' ', $self->{_rebase}{$enzyme});

   return keys %sites;
}
sub get_bionetfile {
   my($self) = @_;
   return $self->{_bionetfile};
}
sub get_dbmfile {
   my($self) = @_;
   return $self->{_dbmfile};
}
sub get_mode {
   my($self) = @_;
   return $self->{_mode};
}
datafile begins like this:
REBASE version 212                                              bionet.212
   =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
   REBASE, The Restriction Enzyme Database   http://rebase.neb.com
   Copyright (c)  Dr. Richard J. Roberts, 2002.   All rights reserved.
   =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Rich Roberts                                                    Dec 01 2002
AaaI (XmaIII)                     C^GGCCG
AacI (BamHI)                      GGATCC
AaeI (BamHI)                      GGATCC
AagI (ClaI)                       AT^CGAT
AaqI (ApaLI)                      GTGCAC
AarI                              CACCTGCNNNN^
AarI                              ^NNNNNNNNGCAGGTG
AasI (DrdI)                       GACNNNN^NNGTC
AatI (StuI)                       AGG^CCT
AatII                             GACGT^C
AauI (Bsp1407I)                   T^GTACA
last field of each line is the recognition site. These are given using IUB codes for nucleotides.
(For the IUB codes, see the comments in the program.)
digests in the computer when determining if there are overhangs that will be useful when
recognition sites. Cut sites are omitted to simplify the code. (See the exercises for more on
handling cut sites.)
sub parse_rebase {

   my($self) = @_;
   # handles multiple definition lines for an enzyme name
   # also handles alternate enzyme names on a line
   # Read in the bionet(Rebase) file
   unless(open(BIONETFH, $self->{_bionetfile})) {
       croak("Cannot open bionet file $self->{_bionetfile}");
   }
   while(<BIONETFH>) {
       my @names = (  );
       # Discard header lines
       next if ( 1 .. /Rich Roberts/ );# discard all lines from the first
line
                                       # to the first line containing "Rich
Roberts"
       # Discard blank lines
       next unless /\S/; # discard a line unless it contains something not
                         # whitespace
       # Split the two (or three if includes parenthesized name) fields
       my @fields = split;
       # Get and store the recognition site
       my $site = pop @fields;
       # For the purposes of this exercise, I'll ignore cut sites (^).
       # This is not something you'd want to do in general, however!
       $site =~ s/\^//g;
       # Get and store the name and the recognition site.
       # Add alternate (parenthesized) names
       # from the middle field, if any
       foreach my $name (@fields) {
           $name =~ tr/)(//d;  # delete parentheses
           push @names, $name;
       }
       # Store the data into the hash, avoiding duplicates (ignoring ^ cut
sites)
       # and ignoring reverse complements
       # Because these values are stored via DBM, I cannot use anything but
       #  a scalar string to store the site/regularexpression pairs,
space-separated
       #  (but see the exercises)
       foreach my $name (@names) {
           # Add new enzyme definition
           unless(exists $self->{_rebase}{$name}) {
               $self->{_rebase}{$name} = "$site " . IUB_to_regexp($site);
               next;
           }
           my(%defined_sites) = split(' ', $self->{_rebase}{$name});
           # Omit already defined sites
           if(exists $defined_sites{$site}) {
               next;
           # Omit reverse complements of already defined sites

           }elsif(exists $defined_sites{revcomIUB($site)}) {
               next;
           # Add the additional site
           }else{
               $self->{_rebase}{$name}  .= " $site " . IUB_to_regexp($site);
           }
       }
   }
   return 1;
}
For instance, because enzymes can appear on more than one line, it has to check if an
enzyme was already entered as a key in the hash.
Let me remind you of the range operator that is used here to skip header lines:
# Discard header lines
next if ( 1 .. /Rich Roberts/ );  # discard all lines from the first line
                                  # to the first line containing "Rich
Roberts"
manual for all the details on the range operator.)
each data line in a while loop. Each line is split into either two fields (name and recognition
names are placed in the @names array and looped through. In the last foreach loop, if the
site to a regular expression. The program passes to the next name.
sites are examined, and if the new site is there, the program passes to the next name.
Similarly, if the reverse complement of the site has been entered, the program passes to the
next name. But otherwise (if the enzyme name was entered, but neither the site nor its
reverse complement were in the list of sites for that enzyme), the recognition site is added
with its translation to a regular expression.
indicate that the enzyme can cut the site on both strands.
Although the code presented here ignores cut sites, the exercises will ask
you to reconsider them; note that if the cut site isn't exactly in the
middle, there will be "sticky ends" of single stranded DNA that make it
possible to anneal the fragment with a complementary sticky end. Refer
to a standard molecular biology textbook for the essential biology of
restriction enzymes. (The logic used here to handle reverse complements
might not be ideal for all situations: see the exercises.) 
sub revcomIUB {
   my($seq) = @_;

   my $revcom = reverse complementIUB($seq);
   return $revcom;
}
sub complementIUB {
   my($seq) = @_;
   (my $com = $seq) =~ tr [ACGTRYMKSWBDHVNacgtrymkswbdhvn]
                             [TGCAYRKMWSVHDBNtgcayrkmwsvhdbn];
   return $com;
}
# Translate IUB ambiguity codes to regular expressions 
# IUB_to_regexp
#
# A subroutine that, given a sequence with IUB ambiguity codes,
# outputs a translation with IUB codes changed to regular expressions
#
# These are the IUB ambiguity codes
# (Eur. J. Biochem. 150: 1-5, 1985):
# R = G or A
# Y = C or T
# M = A or C
# K = G or T
# S = G or C
# W = A or T
# B = not A (C or G or T)
# D = not C (A or G or T)
# H = not G (A or C or T)
# V = not T (A or C or G)
# N = A or C or G or T 
sub IUB_to_regexp {
   my($iub) = @_;
   my $regular_expression = '';
   my %iub2character_class = (
       A => 'A',
       C => 'C',
       G => 'G',
       T => 'T',
       R => '[GA]',
       Y => '[CT]',
       M => '[AC]',
       K => '[GT]',
       S => '[GC]',
       W => '[AT]',
       B => '[CGT]',
       D => '[AGT]',
       H => '[ACT]',
       V => '[ACG]',
       N => '[ACGT]',
   );
   # Remove the ^ signs from the recognition sites
   $iub =~ s/\^//g;
   # Translate each character in the iub sequence

   for ( my $i = 0 ; $i < length($iub) ; ++$i ) {
       $regular_expression
         .= $iub2character_class{substr($iub, $i, 1)};
   }
   return $regular_expression;
}
1;
=head1 Rebase
Rebase: A simple interface to recognition sites and translations of them into
       regular expressions, from the Restriction Enzyme Database (Rebase)
=head1 Synopsis
   use Rebase;
   # Use "bionetfile" to create and populate dbm file
   my $rebase = Rebase->new(
       dbmfile => 'BIONET',
       bionetfile => 'bionet.212',
       mode => 0644
   );
   # Use without "bionetfile" to attach to existing dbm file
   my $rebase = Rebase->new(
       dbmfile => 'BIONET',
       mode => 0444
   );
   my $enzyme = 'EcoRI';
   print "Looking up restriction enzyme $enzyme\n";
   my @sites = $rebase->get_recognition_sites($enzyme);
   print "Sites are @sites\n";
   my @res = $rebase->get_regular_expressions($enzyme);
   print "Regular expressions are @res\n";
   print "DBM file is ", $rebase->get_dbmfile, "\n";
   print "Rebase bionet file is ", $rebase->get_bionetfile, "\n";
=head1 AUTHOR
James Tisdall
=head1 COPYRIGHT
Copyright (c) 2003, James Tisdall
=cut
Ending the module, as usual, is some POD documentation for the module. Recall that you can
view the output of this documentation in various ways, as HTML on a web page, as
perldoc Rebase.pm

are two alternate calls to Rebase->new, so you should comment out the first one, then the
when you run it with the command:
perl testRebase
you get the following output:
Looking up restriction enzyme EcoRI
Sites are GAATTC
Regular expressions are GAATTC
DBM file is BIONET
Rebase bionet file is bionet.212
[
Tea
m
LiB ]

5.3 Restriction.pm: Finding Recognition Sites
but it is fairly short because it just tries to do a small job. This new Restriction class takes
in the sequence. (Note that it doesn't use inheritance; it simply creates a Rebase object to
use.)
that as the book progresses.
package Restriction;
#
# A class to find locations of restriction enzyme recognition sites in
#  DNA sequence data.
#
use strict;
use warnings;
use Carp;
# Class data and methods
{
  # A list of all attributes with default values.
  # "enzyme" is given as an argument possibly multiple time, set as key to
_map hash
   my %_attributes = (
       _rebase      => { },  # A Rebase.pm hash-based object
       # key   = restriction enzyme name
       # value = space-separated string of recognition sites => regular
expressions
       _sequence    => '', # DNA sequence data in raw format (only bases)
       _map         => { },# a hash: keys are enzyme names, 
                           # values are arrays of locations 
       _enzyme      => '', # space- or comma-separated enzyme names, 
                           # set as key to _map hash
   );
   # Global variable to keep count of existing objects
   my $_count = 0;
   # Return a list of all attributes
   sub _all_attributes {
       keys %_attributes;
   }
   # Manage the count of existing objects
   sub get_count {

       $_count;
   }
   sub _incr_count {
       ++$_count;
   }
   sub _decr_count {
       --$_count;
   }
}
attributes. One is just the DNA sequence data, _sequence.
The attribute _map is a hash that stores the computed restriction map with a key for each
recognition sites for that enzyme occur.
The attribute _enzyme is one or more enzyme names separated by spaces or commas.
recognition sites of restriction enzymes. When you call Restriction->new you must include
documentation later in this section.
objects.
Next, the new constructor method creates and initializes Restriction objects:
# The "new" constructor method, called from class, e.g.
sub new {
   my ($class, %args) = @_;
   # Create a new object
   my $self = bless {  }, $class;
   # Set the attributes for the provided arguments
   foreach my $attribute ($self->_all_attributes(  )) {
       # E.g. attribute = "_name",  argument = "name"
       my($argument) = ($attribute =~ /^_(.*)/);
       if (exists $args{$argument}) {
           if($argument eq 'enzyme') {
               # permit space or comma separated enzyme names
               $args{$argument} =~ s/,/ /g;
           }
           $self->{$attribute} = $args{$argument};
       }
   }
   # Check that the correct arguments are given
   if( not defined $self->{_rebase} ) {
       croak "A Rebase object must be given as an argument";
   }elsif( ref($self->{_rebase}) ne 'Rebase' ) {
       croak "The argument to rebase is not a Rebase object";
   }elsif( not defined $self->{_sequence} ) {
       croak "A sequence must be given as an argument";
   }
   # Calculate the locations for each enzyme, store in _map hash attribute

   foreach my $enzyme (split(" ", $self->{_enzyme})) {
       $self->map_enzyme($enzyme);
   }
   $self->_incr_count;
   return $self;
}
# For this simple class I have no AUTOLOAD or DESTROY
# No get_rebase method, I don't want to pass around a huge hash
# No set mutators: all initialization done by way of "new" constructor
# No clone method.  Each sequence and set of enzymes can be easily calculated
#  by means of a "new" command.
sequence, enzyme(s), and a Rebase object.
Then the new constructor performs the required computation by calling the method
map_enzyme for each enzyme to determine the (possibly empty) array of locations in which
_map attribute.
works by getting the regular expressions that have been calculated for the enzyme and then
finding the positions where the regular expressions match the sequence.
Restriction->new constructor method and appears as the $self->{_rebase} attribute. In
that object, the attribute _rebase is the hash of the database, which looks for the value of
the key $enzyme.
The match_positions method puts a match of a regular expression in a while loop, where it
loops once for each location it finds. The offset of the matching sequence is available in the
special variable $-[0] after a successful regular-expression match (see the perlvar section
of the Perl documentation for more details).
sub map_enzyme {
   my($self, $enzyme) = @_;
   my(@positions) = (  );
   my(@res) = $self->get_regular_expressions($enzyme);
   foreach my $re (@res) {
       push @positions, $self->match_positions($re);
   }
   @{$self->{_map}{$enzyme}} = @positions;
   return @positions;
}
sub get_regular_expressions {
   my($self, $enzyme) = @_;
   my(%sites) = split(' ', $self->{_rebase}{_rebase}{$enzyme});
   # May have duplicate values

   return values %sites;
}
# Find positions of a regular expression in the sequence
sub match_positions {
   my($self, $regexp) = @_;
   my @positions = (  );
   # Determine positions of regular expression matches
   while ( $self->{_sequence} =~ /$regexp/ig ) {
       push @positions, ($-[0] + 1 );
   }
   return(@positions);
}
calculated map for a given enzyme (or the entire hash that contains the map of all the
enzymes). I didn't use AUTOLOAD here because there are only a handful of attributes that
return a few different data types: array, scalar string, and hash.
sub get_enzyme_map {
   my($self, $enzyme) = @_;
   @{$self->{_map}{$enzyme}};
}
sub get_enzyme_names {
   my($self) = @_;
   keys %{$self->{_map}};
}
sub get_sequence {
   my($self) = @_;
   $self->{_sequence};
}
sub get_map {
   my($self) = @_;
   %{$self->{_map}};
}
Here's the (bare bones) documentation for the class embedded right in the module using the
POD documentation language:
=head1 Restriction
Restriction: Given a Rebase object, sequence, and list of restriction enzyme
   names, return the locations of the recognition sites in the sequence
=head1 Synopsis
   use Restriction;
   use Rebase;
   use strict;
   use warnings;
   my $rebase = Rebase->new(

       dbmfile => 'BIONET',
       bionetfile => 'bionet.212'
   );
   my $restrict = Restriction->new(
       rebase => $rebase,
       enzyme => 'EcoRI, HindIII',
       sequence => 'ACGAATTCCGGAATTCG',
   );
  
   print "Locations for EcoRI are ", join(' ', 
                                   $restrict->get_enzyme_map('EcoRI')),
"\n";
=head1 AUTHOR
James Tisdall
=head1 COPYRIGHT
Copyright (c) 2003, James Tisdall
=cut
1;
file is in place) gives the output:
EcoRI data in Rebase is GAATTC GAATTC
Sequence is ACGAATTCCGGAATTCG
Locations for EcoRI are 3 11
[
Tea
m
LiB ]

5.4 Drawing Restriction Maps
display of a program's results.
I designed my base class Restriction.pm to represent the restriction map as a simple list of
recognition site locations because I wanted my software to be flexible enough to be extended
to accommodate any of the many different graphic formats that might be desired.
discovery, and none at all.
But even if you need a program that's restricted to text output, you still need to spend
simple map drawing capability to the software, drawn as simple text.
software.
recognition sites for each enzyme requested, and stored it in the _map attribute. I can also
I'm not sure which graphics system I'll use in the future; for now, a simple text output may
likely that I'll be able to compute the graphics output very quickly, so the need for storing it is
less compelling. And storing a large image for possibly hundreds or thousands of objects will
be a strain on the computer system.
However, I may not be able to calculate quickly for fancier, full color, high resolution graphics
which case having them precalculated would be a necessity!
Also, how about multiple digests? Should I just create one graphic for the entire set of
enzymes in an object or add a single digest graphic for each enzyme?
one enzyme if desired).
