use strict;
use warnings;
our $AUTOLOAD; # before Perl 5.6.0 say "use vars '$AUTOLOAD';"
use Carp;
# Class data and methods, that refer to the collection of all objects
# in the class, not just one specific object
{
   my $_count = 0;
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
# The constructor for the class
sub new {
   my ($class, %arg) = @_;
   my $self = bless {
       _name        => $arg{name}      || croak("Error: no name"),
       _organism    => $arg{organism}  || croak("Error: no organism"),
       _chromosome  => $arg{chromosome}|| "????",
       _pdbref      => $arg{pdbref}    || "????",
       _author      => $arg{author}    || "????",
       _date        => $arg{date}      || "????",
   }, $class;
   $class->_incr_count(  );
   return $self;
}
# This takes the place of such accessor definitions as:
#  sub get_attribute { ... }
# and of such mutator definitions as:
#  sub set_attribute { ... }
sub AUTOLOAD {
   my ($self, $newvalue) = @_;

   my ($operation, $attribute) = ($AUTOLOAD =~ /(get|set)(_\w+)$/);
   
   # Is this a legal method name?
   unless($operation && $attribute) {
       croak "Method name $AUTOLOAD is not in the recognized form (get|set)_
attribute\n";
   }
   unless(exists $self->{$attribute}) {
       croak "No such attribute '$attribute' exists in the class ",
ref($self);
   }
   # Turn off strict references to enable "magic" AUTOLOAD speedup
   no strict 'refs';
   # AUTOLOAD accessors
   if($operation eq 'get') {
       # define subroutine
       *{$AUTOLOAD} = sub { shift->{$attribute} };
   # AUTOLOAD mutators
   }elsif($operation eq 'set') {
       # define subroutine
       *{$AUTOLOAD} = sub { shift->{$attribute} = shift; };
       # set the new attribute value
       $self->{$attribute} = $newvalue;
   }
   # Turn strict references back on
   use strict 'refs';
   # return the attribute value
   return $self->{$attribute};
}
# When an object is no longer being used, this will be automatically called
# and will adjust the count of existing objects
sub DESTROY {
   my($self) = @_;
   $self->_decr_count(  );
}
# Other methods.  They do not fall into the same form as the majority handled
by 
AUTOLOAD
# This is an example of a method that is both accessor and mutator, depending
on the
# number of arguments provided to it.
sub citation {
   my ($self, $author, $date) = @_;
   $self->{_author} = set_author($author) if $author;
   $self->{_date} = set_date($date) if $date;
   return ($self->{_author}, $self->{_date})
}
1;
#!/usr/bin/perl

#
# Test the third version of the Gene module
#
use strict;
use warnings;
# Change this line to show the folder where you store Gene.pm
use lib "/home/tisdall/MasteringPerlBio/development/lib";
use Gene3;
print "Object 1:\n\n";
# Create first object
my $obj1 = Gene3->new(
       name            => "Aging",
       organism        => "Homo sapiens",
       chromosome      => "23",
       pdbref          => "pdb9999.ent"
); 
# Print the attributes of the first object
print $obj1->get_name, "\n";
print $obj1->get_organism, "\n";
print $obj1->get_chromosome, "\n";
print $obj1->get_pdbref, "\n";
# Test AUTOLOAD failure: try uncommenting one or both of these lines
#print $obj1->get_exon, "\n";
#print $obj1->getexon, "\n";
print "\n\nObject 2:\n\n";
# Create second object
my $obj2 = Gene3->new(
       organism        => "Homo sapiens",
       name            => "Aging",
); 
# Print the attributes of the second object ... some will be unset
print $obj2->get_name, "\n";
print $obj2->get_organism, "\n";
print $obj2->get_chromosome, "\n";
print $obj2->get_pdbref, "\n";
# Reset some of the attributes of the second object
$obj2->set_name("RapidAging");
$obj2->set_chromosome("22q");
$obj2->set_pdbref("pdf9876.ref");
$obj2->set_author("D. Enay");
$obj2->set_date("February 9, 1952");
print "\n\n";
# Print the reset attributes of the second object
print $obj2->get_name, "\n";
print $obj2->get_organism, "\n";
print $obj2->get_chromosome, "\n";
print $obj2->get_pdbref, "\n";
print $obj2->citation, "\n";
# Use a class method to report on a statistic about all existing objects
print "\nCount is ", Gene3->get_count, "\n\n";

print "\n\nObject 3:\n\n";
# Create a third object: but this fails
#  because the "name" value is required (see Gene.pm)
my $obj3 = Gene3->new(
       organism        => "Homo sapiens",
       chromosome      => "23",
       pdbref          => "pdb9999.ent"
); 
# This line is not reached due to the fatal failure to
#  create the third object
print "\nCount is ", Gene3->get_count, "\n\n";
Finally, here is the output from running the test program testGene3:
Object 1:
Aging
Homo sapiens
pdb9999.ent
Object 2:
Aging
Homo sapiens
????
????
RapidAging
Homo sapiens
22q
pdf9876.ref
D. EnayFebruary 9, 1952
Count is 2
Object 3:
Error: no name at testGene3 line 70
[
Tea
m
LiB ]

3.9 How AUTOLOAD Works
as shown, because Perl is designed that way. Don't use the subroutine name AUTOLOAD (or
DESTROY) for any other purpose, or you'll suffer unintended consequences.
subroutine simply produces an error when the program runs. But if an AUTOLOAD subroutine is
same time, the $AUTOLOAD variable is set to the name of the undefined subroutine.
#!/usr/bin/perl
use strict;
use warnings;
print "I started the program\n";
report_protein_function("one", "two");
print "I got to the end of the program\n";
It gives the following output:
I started the program
Undefined subroutine &main::report_protein_function called at jk.pl line 8.
Here's what happens when an AUTOLOAD subroutine is defined in the package:
#!/usr/bin/perl
use strict;
use warnings;
use vars '$AUTOLOAD';
print "I started the program\n";
report_protein_function("one", "two");
print "I got to the end of the program\n";
sub AUTOLOAD {
       print "AUTOLOAD is set to $AUTOLOAD\n";
       print "with arguments ", "@_\n";
}
It gives the following output:
I started the program
AUTOLOAD is set to main::report_protein_function
with arguments one two
I got to the end of the program
Recall that when you start programs with such statements as:
use strict;

your program needs to use global variables that aren't lexically scoped. To use AUTOLOAD, you
need access to the predefined $AUTOLOAD global variable.
To enable access of the package global $AUTOLOAD, you must specifically exempt it from the
use strict injunction. This can be accomplished with the use vars statement:
use vars '$AUTOLOAD';
preferably not at all.
even when use strict is in effect:
our $AUTOLOAD;
This makes the variable $AUTOLOAD a legal global within the scope in which it is declared in
Gene3.pm, the scope is the entire class.
Without our $AUTOLOAD or use vars '$AUTOLOAD', the program won't run; instead, it
complains vociferously that:
Global symbol "$AUTOLOAD" requires explicit package name
two previous versions Gene1.pm and Gene2.pm.
method for each attribute. This is repetitive; it requires defining more methods every time the
list of attributes changes, and, in general, it's hard to maintain such code.
The new version Gene3.pm uses AUTOLOAD to automate the handling of methods for
similar, basic methods are handled in the same fashion by the one bit of code.
AUTOLOAD starts by fiddling with the use strict statement. Just as it requires the $AUTOLOAD
global variable to be exempted from the use strict directive, so does the magic AUTOLOAD
speedup (described in the next section) require an exemption from the use strict directive
at a specific place within the AUTOLOAD subroutine. Thus, the statement:
no strict "refs";
turns off the use strict where required. This enables the lines (to be explained later) such
as:
*{$AUTOLOAD} = sub { return $_[0]->{$attribute} };
to bypass the otherwise desirable use strict instruction.
have gone to the undefined subroutine.
For example, say you call an undefined method fold on an object $peptide:
$peptide->fold(-style => 'prion')
name, as usual, plus the arguments -style => 'prion' you were trying to pass to the

nonexistent fold method. The global scalar variable $AUTOLOAD is also set to the name of the
nonexistent fold method.
subroutine by arrow notation, which appears first, and the other arguments, if any. This line in
the AUTOLOAD subroutine:
my ($self, $newvalue) = @_;
assigns the reference to the object to the new variable $self and the value to be set, if any,
to the new variable $newvalue.
for example, _name for the gene name. The accessors and mutators for attributes have been
example, get_name and set_name.
examines the name of the called subroutine as stored in the $AUTOLOAD global variable,
checks if the subroutine name is in the expected form, and if so, extracts the attribute name
The first part of the AUTOLOAD subroutine does some checking to see if the subroutine name
is in the expected form, and if so, it extracts the attribute name, and the requested operation
(get or set). This first test:
my ($operation, $attribute) = ($AUTOLOAD =~ /(get|set)(_\w+)$/);
   
# Is this a legal method name?
unless($operation && $attribute) {
  croak "Method name $AUTOLOAD is not in the recognized form
(get|set)_attribute\n";
}
unless(exists $self->{$attribute}) {
  croak "No such attribute '$attribute' exists in the class ", ref($self);
   }
uses a regular expression to see if the $AUTOLOAD variable is storing a method name that
ends with an attribute name (complete with leading underscore) that is defined for objects of
this class if it begins with get or set as the desired operation. The regular expression:
(get|set)(_\w+)$
looks for a name that, after get or set, is composed of an underscore followed by one or
_\w+
in the $operation and $attribute variables by surrounding with parentheses the parts of
the regular expression that match the operation and the attribute name:
(get|set)(_\w+)
This attribute name is assigned to the variable $attribute (for obvious mnemonic reasons)
to use in the rest of the subroutine. Similarly, the operation get or set is assigned to the
$operation variable.
The second part of the test checks to see if such an attribute name exists in the hash that

represents the class object:
unless(exists $self->{$attribute}) {
   croak "No such attribute '$attribute' exists in the class ", ref($self);
}
The exists Perl command checks to see if a hash key exists; the value for the key may not
have been set, but the key must exist. $self is the reference to the class object, so the
following:
exists $self->{$attribute}
checks to see if any such attribute actually exists in the object.
leading underscore, and if that name is an existing key in the hash that is the class object, the
tests will succeed. If they fail, the program will croak at this point.
The next bit of AUTOLOAD code handles the calls to class accessors:
# AUTOLOAD accessors
if($operation eq 'get') {
   # define subroutine
   *{$AUTOLOAD} = sub { shift->{$attribute} };
}
method (whose name has been saved in the variable $AUTOLOAD) is defined. The subroutine
definition is placed in the program's symbol table with *{$AUTOLOAD}. The new subroutine
in the hash for the attribute is returned from the subroutine. So this method is a simple
here; it's just defined in the symbol table.
The next bit of AUTOLOAD code handles the calls to class mutators:
# AUTOLOAD mutators
}elsif($operation eq 'set') {
   # define subroutine
   *{$AUTOLOAD} = sub { shift->{$attribute} = shift; };
   # set the new attribute value
   $self->{$attribute} = $newvalue;
}
method (whose name has been saved in the variable $AUTOLOAD) is defined. The new
$newvalue that was passed in as an argument.
case may be, and setting the new value of the attribute if a mutator method has been
defined, returns the value of the attribute:
# return the attribute value
return $self->{$attribute};
like the defined accessor or mutator method by returning the attribute value (if it's a mutator,
it first resets the attribute).

*{$AUTOLOAD} = sub { shift->{$attribute} };
and:
*{$AUTOLOAD} = sub { shift->{$attribute} = shift; };
are there purely in order to speed up the code.
methods, the use of regular expressions to parse the names of the methods, etc.
the symbol table of the running program. So, for instance, the second time that the accessor
isn't called. This results in a considerable speedup for the program overall.
I'll not delve too deeply into how this works. Briefly, the $AUTOLOAD variable contains the
name of the desired method call, say, get_name. The star * in *{$AUTOLOAD} is a reference to
subroutine definition.
details, see O'Reilly's Programming Perl.
[
Tea
m
LiB ]

3.10 Cleaning Up Unused Objects with DESTROY
can just leave the memory as it is, unused, and go on and use other memory for other tasks.
No clean up is strictly necessary.
However, this might, and does, cause problems with certain kinds of programs. Some
computer's memory is finite; for a program that runs a long time and examines a continuous
source of data (say, for instance, the data generated by your sequencing facility), it will at
some point use all available main memory.
reused by the program. This is sometimes called the garbage collection problem.
literature, which won't be discussed here.
variable goes out of scope. For instance, in the following code fragment, the variable $i goes
out of scope after the if block, and its memory is cleaned up, making it available to the rest
of the program:
if(1) {
       my $i = 'ACCGGCCGGCCGGTTAATGCATAATC';
       determine_function($i);
}
# $i has gone out of scope here
program continues, the object goes out of scope. For instance, if the object was created
count of the number of objects will now be off by one!
subroutine. Perl calls the DESTROY method 1) if you've defined a method with that name in
of scope. It does so automatically, just as AUTOLOAD is automatically called if you attempt to
call a method that doesn't exist on a class object.
subroutine will thus suffice:
sub DESTROY {
   my($self) = @_;
   $self->_decr_count(  );
}
Let's see if it works. Here's a test program, testGeneGC (GC for garbage collection):
#!/usr/bin/perl

#
# Test the garbage collection of the Gene.pm module
#
use strict;
use warnings;
# Change this line to show the folder where you store Gene.pm
use lib "/home/tisdall/MasteringPerlBio/development/lib";
use Gene;
print "\nCount is ", Gene->get_count, "\n\n";
if(1) {
   # Create first object
   my $obj1 = Gene->new(
           name                => "Gene1",
           organism            => "Homo sapiens",
   ); 
   
       print "\nCount is ", Gene->get_count, "\n\n";
   
   # Create second object
   my $obj2 = Gene->new(
           name                => "Gene2",
           organism            => "Homo sapiens",
   ); 
   
   print "\nCount is ", Gene->get_count, "\n\n";
   
   # Create a third object
   my $obj3 = Gene->new(
           name                => "Gene3",
           organism            => "Homo sapiens",
   ); 
   print "\nCount is ", Gene->get_count, "\n\n";
}
print "\nCount is ", Gene->get_count, "\n\n";
if block go out of scope, the count is properly set back to zero:
Count is 0
Count is 1
Count is 2
Count is 3
Count is 0
Now, try the test program testGeneGC to get the following output:
Count is 0
Count is 1
Count is 2
Count is 3
Count is 3
sometimes a necessity.

structures, see Section 3.14.
[
Tea
m
LiB ]

3.11 Gene.pm: A Fourth Example of a Perl Class
standard and simple way in which the documentation for a class can be incorporated into the 
.pm file. This will conclude my introduction to OO Perl programming (but check out the
exercises at the end of the chapter and see later chapters of this book for more ideas).
Here then is the code for Gene.pm. Again, I recommend that you take the time to read this
that follows:
package Gene;
#
# A fourth and final version of the Gene.pm class
#
use strict;
use warnings;
our $AUTOLOAD; # before Perl 5.6.0 say "use vars '$AUTOLOAD';"
use Carp;
# Class data and methods
{
   # A list of all attributes with default values and read/write/required
properties
   my %_attribute_properties = (
       _name        => [ '????',        'read.required'],
       _organism    => [ '????',        'read.required'],
       _chromosome  => [ '????',        'read.write'],
       _pdbref      => [ '????',        'read.write'],
       _author      => [ '????',        'read.write'],
       _date        => [ '????',        'read.write'],
   );
       
   # Global variable to keep count of existing objects
   my $_count = 0;
   # Return a list of all attributes
   sub _all_attributes {
           keys %_attribute_properties;
   }
   # Check if a given property is set for a given attribute
   sub _permissions {
       my($self, $attribute, $permissions) = @_;
       $_attribute_properties{$attribute}[1] =~ /$permissions/;
   }
   # Return the default value for a given attribute
   sub _attribute_default {
           my($self, $attribute) = @_;
       $_attribute_properties{$attribute}[0];

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
# The constructor method
# Called from class, e.g. $obj = Gene->new(  );
sub new {
   my ($class, %arg) = @_;
   # Create a new object
   my $self = bless {  }, $class;
   foreach my $attribute ($self->_all_attributes(  )) {
       # E.g. attribute = "_name",  argument = "name"
       my($argument) = ($attribute =~ /^_(.*)/);
       # If explicitly given
       if (exists $arg{$argument}) {
           $self->{$attribute} = $arg{$argument};
       # If not given, but required
       }elsif($self->_permissions($attribute, 'required')) {
           croak("No $argument attribute as required");
       # Set to the default
       }else{
           $self->{$attribute} = $self->_attribute_default($attribute);
       }
   }
   $class->_incr_count(  );
   return $self;
}
# The clone method
# All attributes will be copied from the calling object, unless
# specifically overridden
# Called from an exisiting object, e.g. $cloned_obj = $obj1->clone(  );
sub clone {
   my ($caller, %arg) = @_;
   # Extract the class name from the calling object
   my $class = ref($caller);
   # Create a new object
   my $self = bless {  }, $class;
   foreach my $attribute ($self->_all_attributes(  )) {
       # E.g. attribute = "_name",  argument = "name"
       my($argument) = ($attribute =~ /^_(.*)/);
       # If explicitly given
       if (exists $arg{$argument}) {
           $self->{$attribute} = $arg{$argument};
       # Otherwise copy attribute of new object from the calling object
       }else{
           $self->{$attribute} = $caller->{$attribute};
       }
   }
   $self->_incr_count(  );
   return $self;

}
# This takes the place of such accessor definitions as:
#  sub get_attribute { ... }
# and of such mutator definitions as:
#  sub set_attribute { ... }
sub AUTOLOAD {
   my ($self, $newvalue) = @_;
   my ($operation, $attribute) = ($AUTOLOAD =~ /(get|set)(_\w+)$/);
   
   # Is this a legal method name?
   unless($operation && $attribute) {
       croak "Method name $AUTOLOAD is not in the recognized form (get|set)_
attribute\n";
   }
   unless(exists $self->{$attribute}) {
       croak "No such attribute $attribute exists in the class ",
ref($self);
   }
   # Turn off strict references to enable "magic" AUTOLOAD speedup
   no strict 'refs';
   # AUTOLOAD accessors
   if($operation eq 'get') {
       # Complain if you can't get the attribute
       unless($self->_permissions($attribute, 'read')) {
           croak "$attribute does not have read permission";
       }
       # Install this accessor definition in the symbol table
       *{$AUTOLOAD} = sub {
           my ($self) = @_;
           unless($self->_permissions($attribute, 'read')) {
               croak "$attribute does not have read permission";
           }
           $self->{$attribute};
       };
   # AUTOLOAD mutators
   }elsif($operation eq 'set') {
       # Complain if you can't set the attribute
       unless($self->_permissions($attribute, 'write')) {
           croak "$attribute does not have write permission";
       }
       # Set the attribute value
       $self->{$attribute} = $newvalue;
       # Install this mutator definition in the symbol table
       *{$AUTOLOAD} = sub {
              my ($self, $newvalue) = @_;
           unless($self->_permissions($attribute, 'write')) {
               croak "$attribute does not have write permission";
           }
           $self->{$attribute} = $newvalue;
       };
   }
   # Turn strict references back on

   use strict 'refs';
   # Return the attribute value
   return $self->{$attribute};
}
# When an object is no longer being used, this will be automatically called
# and will adjust the count of existing objects
sub DESTROY {
   my($self) = @_;
   $self->_decr_count(  );
}
# Other methods.  They do not fall into the same form as the majority handled
by 
AUTOLOAD
sub citation {
   my ($self, $author, $date) = @_;
   $self->{_author} = set_author($author) if $author;
   $self->{_date} = set_date($date) if $date;
   return ($self->{_author}, $self->{_date})
}
1;
=head1 Gene
Gene: objects for Genes with a minimum set of attributes
=head1 Synopsis
   use Gene;
   my $gene1 = Gene->new(
       name       => 'biggene',
       organism   => 'Mus musculus',
       chromosome => '2p',
       pdbref     => 'pdb5775.ent',
       author     => 'L.G.Jeho',
       date       => 'August 23, 1989',
   );
   print "Gene name is ", $gene1->get_name(  );
   print "Gene organism is ", $gene1->get_organism(  );
   print "Gene chromosome is ", $gene1->get_chromosome(  );
   print "Gene pdbref is ", $gene1->get_pdbref(  );
   print "Gene author is ", $gene1->get_author(  );
   print "Gene date is ", $gene1->get_date(  );
   $clone = $gene1->clone(name => 'biggeneclone');
   $gene1-> set_chromosome('2q');
   $gene1-> set_pdbref('pdb7557.ent');
   $gene1-> set_author('G.Mendel');
   $gene1-> set_date('May 25, 1865');
   $clone->citation('T.Morgan', 'October 3, 1912');
   print "Clone citation is ", $clone->citation;
=head1 AUTHOR
A kind reader

=head1 COPYRIGHT
Copyright (c) 2003, We Own Gene, Inc.
=cut

It collects them in their own hash, %_attribute_properties. This makes it easier to
rest of the code will behave accordingly.

It enables you to specify default values for each attribute. In the Gene.pm class, I just
specify the string ???? as the default for each attribute, but any values could be
specified.

This attribute hash specifies, for each attribute, whether it is permitted to read or write
it, and if it is required to have a nondefault value provided.
# A list of all attributes with default values and read/write/required
properties
   my %_attribute_properties = (
       _name        => [ '????',        'read.required'],
       _organism    => [ '????',        'read.required'],
       _chromosome  => [ '????',        'read.write'],
       _pdbref      => [ '????',        'read.write'],
       _author      => [ '????',        'read.write'],
       _date        => [ '????',        'read.write'],
   );
Why have the read/write/required properties been specified? It's because sometimes
overwriting an attribute may get you into deep water; for instance, if you have a unique ID
attributes can help you create safer code.
implementing it in a slightly different way.
This way of specifying properties can easily be expanded. For instance, if you want to add a
data structure, we need a few helper methods to access that information.
First, you need a method that simply returns a list of all the attributes:
# Return a list of all attributes
sub _all_attributes {
       keys %_attribute_properties;
}
Next, you'll want a way to check, for any given attribute and property, if that property is set
for that attribute. The return value is the value of the last statement in the subroutine, which
is true or false depending on whether or not the property $permissions is set for the given

attribute:
# Check if a given property is set for a given attribute
sub _permissions {
   my($self, $attribute, $permissions) = @_;
   $_attribute_properties{$attribute}[1] =~ /$permissions/;
}
Finally, to set attribute values, you'll want to report on the default value for any given
value for the given attribute (this is a hash of arrays, and the code is returning the first
element of the array stored for that attribute, which contains the default value):
# Return the default value for a given attribute
sub _attribute_default {
       my($self, $attribute) = @_;
   $_attribute_properties{$attribute}[0];
}
about the attributes, namely, their default values and their various properties.
method is called as a class method (e.g., Gene->new( )) and uses default values for every
object method (e.g., $geneobject->clone( )).
clone constructor.
# The constructor method
# Called from class, e.g. $obj = Gene->new(  );
sub new {
   my ($class, %arg) = @_;
   # Create a new object
   my $self = bless {  }, $class;
   foreach my $attribute ($self->_all_attributes(  )) {
       # E.g. attribute = "_name",  argument = "name"
       my($argument) = ($attribute =~ /^_(.*)/);
       # If explicitly given
       if (exists $arg{$argument}) {
           $self->{$attribute} = $arg{$argument};
       # If not given, but required
       }elsif($self->_permissions($attribute, 'required')) {
           croak("No $argument attribute as required");
       # Set to the default
       }else{
           $self->{$attribute} = $self->_attribute_default($attribute);
       }
   }
   $class->_incr_count(  );
   return $self;
}
Notice that we start by blessing an empty anonymous hash: bless { }, and then setting the

values of the attributes.
underscore.
The logic of attribute initialization is three part. If an argument and value for an attribute is
according to the properties specified for that attribute, the program croaks. Finally, if no
specified for that attribute.
object is returned.
clone objects will come in handy in bioinformatics!
# The clone method
# All attributes will be copied from the calling object, unless
# specifically overridden
# Called from an exisiting object, e.g. $cloned_obj = $obj1->clone(  );
sub clone {
   my ($caller, %arg) = @_;
   # Extract the class name from the calling object
   my $class = ref($caller);
   # Create a new object
   my $self = bless {  }, $class;
   foreach my $attribute ($self->_all_attributes(  )) {
       # E.g. attribute = "_name",  argument = "name"
       my($argument) = ($attribute =~ /^_(.*)/);
       # If explicitly given
       if (exists $arg{$argument}) {
           $self->{$attribute} = $arg{$argument};
       # Otherwise copy attribute of new object from the calling object
       }else{
           $self->{$attribute} = $caller->{$attribute};
       }
   }
   $self->_incr_count(  );
   return $self;
}
something like:
$newobject = Myclass->new(  );
On the other hand, to clone an existing object, you say something like:
$clonedobject = $newobject->clone(  );

object $newobject.
Now, in the code for the clone method, the class name must be extracted from the caller by
the ref($caller) code because the caller is an object, not a class.
class, and then each attribute is considered in turn in a foreach loop.
two-stage test is made. As before, if the argument is specified, the attribute is set as
of objects is incremented, and the new object is returned.
initialized in the Gene class. This flexibility may prove convenient and useful for you.
The code to AUTOLOAD has been augmented with checks for appropriate permissions for the
to see if the read flag is set in the attribute hash via the _permissions class method. Notice
modified to accommodate this additional test:
# AUTOLOAD accessors
if($AUTOLOAD =~ /.*::get_\w+/) {
   # Install this accessor definition in the symbol table
   *{$AUTOLOAD} = sub {
       my ($self) = @_;
       unless($self->_permissions($attribute, 'read')) {
           croak "$attribute does not have read permission";
       }
       $self->{$attribute};
   };
   # Return the attribute value
   unless($self->_permissions($attribute, 'read')) {
       croak "$attribute does not have read permission";
   }
   return $self->{$attribute};
}
Similarly, the part of AUTOLOAD that defines mutator methods for setting attribute values now
checks for write permissions in a similar fashion.
followed by its output. It's worthwhile to take the time to read the testGene program,
looking back at the class module Gene.pm for the definitions of the objects and methods and
seeing what kind of output the test program creates. Also, see the exercises for suggestions
on how to further modify and extend the capabilities of Gene.pm.
#!/usr/bin/perl
#
# Test the fourth and final version of the Gene module
#
use strict;
use warnings;

# Change this line to show the folder where you store Gene.pm
use lib "/home/tisdall/MasteringPerlBio/development/lib";
use Gene;
print "Object 1:\n\n";
# Create first object
my $obj1 = Gene->new(
       name            => "Aging",
       organism        => "Homo sapiens",
       chromosome      => "23",
       pdbref          => "pdb9999.ent"
); 
# Print the attributes of the first object
print $obj1->get_name, "\n";
print $obj1->get_organism, "\n";
print $obj1->get_chromosome, "\n";
print $obj1->get_pdbref, "\n";
# Test AUTOLOAD failure: try uncommenting one or both of these lines
#print $obj1->get_exon, "\n";
#print $obj1->getexon, "\n";
print "\n\nObject 2:\n\n";
# Create second object
my $obj2 = Gene->new(
       organism        => "Homo sapiens",
       name            => "Aging",
); 
# Print the attributes of the second object ... some will be unset
print $obj2->get_name, "\n";
print $obj2->get_organism, "\n";
print $obj2->get_chromosome, "\n";
print $obj2->get_pdbref, "\n";
# Reset some of the attributes of the second object
# set_name will cause an error
#$obj2->set_name("RapidAging");
$obj2->set_chromosome("22q");
$obj2->set_pdbref("pdf9876.ref");
$obj2->set_author("D. Enay");
$obj2->set_date("February 9, 1952");
print "\n\n";
# Print the reset attributes of the second object
print $obj2->get_name, "\n";
print $obj2->get_organism, "\n";
print $obj2->get_chromosome, "\n";
print $obj2->get_pdbref, "\n";
print $obj2->citation, "\n";
# Use a class method to report on a statistic about all existing objects
print "\nCount is ", Gene->get_count, "\n\n";
print "Object 3: a clone of object 2\n\n";
# Clone an object
my $obj3 = $obj2->clone(
       name            => "screw",
       organism        => "C.elegans",

       author          => "I.Turn",
);
# Print the attributes of the cloned object
print $obj3->get_name, "\n";
print $obj3->get_organism, "\n";
print $obj3->get_chromosome, "\n";
print $obj3->get_pdbref, "\n";
print $obj3->citation, "\n";
print "\nCount is ", Gene->get_count, "\n\n";
print "\n\nObject 4:\n\n";
# Create a fourth object: but this fails
#  because the "name" value is required (see Gene.pm)
my $obj4 = Gene->new(
       organism        => "Homo sapiens",
       chromosome      => "23",
       pdbref          => "pdb9999.ent"
); 
# This line is not reached due to the fatal failure to
#  create the fourth object
print "\nCount is ", Gene->get_count, "\n\n";
Object 1:
Aging
Homo sapiens
pdb9999.ent
Object 2:
Aging
Homo sapiens
????
????
Aging
Homo sapiens
22q
pdf9876.ref
D. EnayFebruary 9, 1952
Count is 2
Object 3: a clone of object 2
screw
C.elegans
22q
pdf9876.ref
I.TurnFebruary 9, 1952
Count is 3
Object 4:
No name attribute as required at testGene line 89

[
Tea
m
LiB ]

3.12 How to Document a Perl Class with POD
part of documenting code for those who have to read it or modify it in the future.
Equally as important is documentation for those who have to use the code. A short, accurate,
practical guide to using a Perl class is absolutely necessary in order for the class to be
generally useful.
To gain access to the documentation, you merely have to type:
perldoc Gene.pm
manpage on the Web, or type perldoc perlpod.)
documentation to a minimum. The POD language is simple; the best way to use it to write
the example shown here; try examining the documentation for some Perl modules on your
computer, for example, perldoc CGI or, if it's installed, perldoc Bioperl.
The Perl interpreter will ignore everything from a line beginning:
=head1
up to a line beginning:
=cut
plain text, nroff, or other formats.
Here's the output you get from typing perldoc Gene.pm:
Gene(3)        User Contributed Perl Documentation        Gene(3)
Gene
      Gene: objects for Genes with a minimum set of attributes
Synopsis
          use Gene;
          my $gene1 = Gene->new(
              name       => 'biggene',
              organism   => 'Mus musculus',
              chromosome => '2p',
              pdbref     => 'pdb5775.ent',
              author     => 'L.G.Jeho',
              date       => 'August 23, 1989',
          );
          print "Gene name is ",        $gene1->get_name(  );
          print "Gene organism is ",    $gene1->get_organism(  );
          print "Gene chromosome is ",  $gene1->get_chromosome(  );
          print "Gene pdbref is ",      $gene1->get_pdbref(  );

          print "Gene author is ",      $gene1->get_author(  );
          print "Gene date is ",        $gene1->get_date(  );
          $clone = $gene1->clone(name => 'biggeneclone');
          $gene1-> set_chromosome('2q');
          $gene1-> set_pdbref('pdb7557.ent');
          $gene1-> set_author('G.Mendel');
          $gene1-> set_date('May 25, 1865');
          $clone->citation('T.Morgan', 'October 3, 1912');
          print "Clone citation is ", $clone->citation;
AUTHOR
      A kind reader
COPYRIGHT
      Copyright (c) 2003, We Own Gene, Inc.
2002-11-25                 perl v5.6.1                    Gene(3)

3.13 Additional Topics
Included in this section are a few more topics you may find useful.
some clever folks have written a Perl module Class::Struct that automates the
construction of classes of this type.
It's worth examining Class::Struct because it can be a great timesaver for some situations.
It's been used to create classes for many widely used modules. Type:
perldoc Class::Struct
to get the whole story.
An important part of OO programming deals with the use of one class to help define another.
You can then use the Protein class to define a new class ZincFingers, which perhaps would
study of zinc fingers.
You'll see the use of class inheritance in the next chapter.

3.14 Resources
these sources for more details on OO programming in Perl.

Object Oriented Perl by Damian Conway (Manning Publishers). This is an excellent
book and is useful for beginners to advanced. It even includes a few bioinformatics
is slightly dated; for example, the material on pseudohashes should be skipped.

The perlobj page from the Perl documentation.

Perl objects.

The perltoot tutorial page from the Perl documentation is a more detailed
introduction to Perl objects.

The perltootc tutorial page from the Perl documentation also includes more
information on class methods.

The perlbot tutorial page from the Perl documentation is a bag of tricks for Perl OO
programming.

Perl OO programming, such as Programming Perl, Perl Cookbook, and Advanced Perl
Programming.

3.15 Exercises
Exercise 3.1
Write brief descriptions of the main features of declarative programming, OO
programming, logic programming, and functional programming. (See Section 3.14.)
Exercise 3.2
Give an example of a programming job that would be better with OO programming
than with declarative programming.
Exercise 3.3
Give an example of a programming job that would be better with declarative
programming than with OO programming.
Exercise 3.4
What bioinformatics problem might be best addressed with logic programming?
Exercise 3.5
Download and use a Perl class from CPAN.
Exercise 3.6
Write a Perl class that manages laboratory supplies.
Exercise 3.7
When would you want a separate initialization method for a class; when would you
want the initialization to be part of the new constructor?
Exercise 3.8
Modify Gene.pm to keep count of how many objects refer to given organisms,
chromosomes, authors, pdb references, and names.
Exercise 3.9
Add a DESTROY method to a class so an object can self-destruct.
Exercise 3.10
Beginning in the code for Gene3.pm you'll find the following regular expression:
    if($AUTOLOAD =~ /.*(_\w+)/) {
        $attribute = $1;
This only catches the last part of a name that has an underscore. What if you want to
allow names such as get_other_var? Write a regular expression that would extract
such names as other_var from get_other_var.
Exercise 3.11
In the code for Gene2.pm you'll find the following regular mutator method:
sub set_name {
    my ($self, $name) = @_;
    $self->{_name} = $name if $name;
}
This breaks if $name has certain values such as "", 0, or 0E0. How can you catch these
cases?

Inheritance
incorporated into later chapters.
making additions as needed. It's a style of software reuse that is particular to object-oriented
design.
in several different biological sequence datafile formats.
The goal is, as always, to learn enough about Perl to develop software for your own needs.
end of the chapter will ask you to extend and improve the code in various ways.

4.1 Inheritance
You've seen the use of modules and how a Perl program can use all the code in a module by
simply loading it with the use command. This is a simple and powerful method of software
use of classes, methods, and objects provides a more structured way to reuse Perl software.
There's another way to reuse Perl classes. It's possible for a class to inherit all the code and
(but treats them as if they were defined in this new derived class), unless it finds them first in
the derived class.
In this chapter, I'll first develop a class FileIO.pm, and then use the technique of inheritance
and then adding methods that handle sequence file formats. I could use the same base class 
database files, and so on. (See the exercises at the end of the chapter.)
hash %_attribute_properties also has to be changed. So in the new class I define a new
class that uses inheritance.
can use the special SUPER class for that purpose. I don't use that in the code for this chapter,
but you should be aware that it is possible to do.

4.2 FileIO.pm: A Class to Read and Write Files
Even though you can easily obtain excellent modules for reading and writing files, this chapter
shows you how to build a simple one from scratch. One reason for doing this is to better
It's not uncommon for a biologist to use several different types of formats of files containing
automating some of these tasks in a new class called SeqFileIO.pm.
order to see clearly how it works, let's start with the simple class FileIO.pm and later use it
to define a more complex class, SeqFileIO.pm.
file contents, date, and write permissions.
I wrote FileIO.pm, I simply made a copy of the Gene.pm module from Chapter 3 and
modified it.
On my Linux system, I started by copying FileIO.pm from Gene.pm and giving it a new
name:
cp Gene.pm FileIO.pm
I then edited the new file FileIO.pm changing the line near the top that says:
package Gene;
to:
package FileIO;
The filename must be the same as the class name, with an additional .pm.
needed by most classes that you'll write in your own software projects.
Following is the code for FileIO, with commentary interspersed:
package FileIO;
#
# A simple IO class for sequence data files
#
use strict;
use warnings;
our $AUTOLOAD; # before Perl 5.6.0 say "use vars '$AUTOLOAD';"
use Carp;

# Class data and methods
{
   # A list of all attributes with defaults and read/write/required/noinit
properties
   my %_attribute_properties = (
       _filename    => [ '',        'read.write.required'],
       _filedata    => [ [ ],       'read.write.noinit'],
       _date        => [ '',         'read.write.noinit'],
       _writemode   => [ '>',        'read.write.noinit'],
   );
       
   # Global variable to keep count of existing objects
   my $_count = 0;
   # Return a list of all attributes
   sub _all_attributes {
           keys %_attribute_properties;
   }
   # Check if a given property is set for a given attribute
   sub _permissions {
       my($self, $attribute, $permissions) = @_;
       $_attribute_properties{$attribute}[1] =~ /$permissions/;
   }
   # Return the default value for a given attribute
   sub _attribute_default {
           my($self, $attribute) = @_;
       $_attribute_properties{$attribute}[0];
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
for the hash %_attribute_properties. This new version of the hash has different attributes
(the filename, the file data, the last modification date of the file, and the mode to use in
writing a file) tailored to the needs of reading and writing files.
may also have noticed that the default value for the filedata attribute is an anonymous
array.

how many objects currently exist.)
# The constructor method
# Called from class, e.g. $obj = FileIO->new(  );
sub new {
   my ($class, %arg) = @_;
   # Create a new object
   my $self = bless {  }, $class;
   $class->_incr_count(  );
   return $self;
}
Why did I do so? Read on.
The read method
The code continues with the read method:
# Called from object, e.g. $obj->read(  );
sub read {
   my ($self, %arg) = @_;
   # Set attributes
   foreach my $attribute ($self->_all_attributes(  )) {
       # E.g. attribute = "_filename",  argument = "filename"
       my($argument) = ($attribute =~ /^_(.*)/);
       # If explicitly given
       if (exists $arg{$argument}) {
           # If initialization is not allowed
           if($self->_permissions($attribute, 'noinit')) {
               croak("Cannot set $argument from read: use set_$argument");
           }
           $self->{$attribute} = $arg{$argument};
       # If not given, but required
       }elsif($self->_permissions($attribute, 'required')) {
           croak("No $argument attribute as required");
       # Set to the default
       }else{
           $self->{$attribute} = $self->_attribute_default($attribute);
       }
   }
   # Read file data
   unless( open( FileIOFH, $self->{_filename} ) ) {
       croak("Cannot open file " .  $self->{_filename} );
   }
   $self->{'_filedata'} = [ <FileIOFH> ];
   $self->{'_date'} = localtime((stat FileIOFH)[9]);
   close(FileIOFH);
}
attributes from the arguments and the defaults as specified in the %_attribute_properties
attributes from the file's contents and its last modification time.
