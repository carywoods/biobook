#!/usr/bin/perl
#
# Test the second version of the Gene module
#
use strict;
use warnings;
# Change this line to show the folder where you store Gene2.pm
use lib "/home/tisdall/MasteringPerlBio/development/lib";
use Gene2;
#
# Create object, print values
#
print "Object 1:\n\n";
my $obj1 = Gene2->new(
       name          => "Aging",
       organism      => "Homo sapiens",
       chromosome    => "23",
       pdbref        => "pdb9999.ent"
); 
print $obj1->get_name, "\n";

print $obj1->get_organism, "\n";
print $obj1->get_chromosome, "\n";
print $obj1->get_pdbref, "\n";
#
# Create another object, print values ... some will be unset
#
print "\n\nObject 2:\n\n";
my $obj2 = Gene2->new(
       organism    => "Homo sapiens",
       name        => "Aging",
); 
print $obj2->get_name, "\n";
print $obj2->get_organism, "\n";
print $obj2->get_chromosome, "\n";
print $obj2->get_pdbref, "\n";
#
# Reset some of the values, print them
#
$obj2->set_name("RapidAging");
$obj2->set_chromosome("22q");
$obj2->set_pdbref("pdf9876.ref");
print "\n\n";
print $obj2->get_name, "\n";
print $obj2->get_organism, "\n";
print $obj2->get_chromosome, "\n";
print $obj2->get_pdbref, "\n";
print "\nCount is ", Gene2->get_count, "\n\n";
#
# Create another object, print values: but this fails
# because the "name" value is required (see the "new"
# constructor in Gene2.pm)
#
print "\n\nObject 3:\n\n";
my $obj3 = Gene2->new(
       organism      => "Homo sapiens",
       chromosome    => "23",
       pdbref        => "pdb9999.ent"
); 
print "\nCount is ", Gene2->get_count, "\n\n";
Finally, here's the output from the test program testGene2:
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
Count is 2
Object 3:
Error: no name at testGene2 line 68
Let's begin examining the module code.
such a variable and some closures that use that variable within a block, you can use the
out of scope and lose its value. This section will explain how this works and how to use it in
your code.
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
This code creates a variable $_count. $_count is a lexical my variable in a block of curly
methods that are also defined in the same block use the variable $_count.This variable
persists throughout the life of the program because the subroutines defined with it are

closures. For example, in the code for the class module Gene2.pm, I use $_count to keep a
name $_count. They aren't meant to be called by the user of the class but are internal to the
count is.
programming construct.
Any block, this one included, creates a new scope for the variables that occur within it. my
variables (also called lexical variables) within a block exist only while the program is
beyond its closing curly brace, the my variables within it go out of scope. In other words, they
they are created anew.
The preceding paragraph is correct; however, there is one important "but."
It is also possible for a subroutine definition to affect the behavior of a lexically scoped
variable. Aha. Read on.
regards to my and blocks. In fact, a subroutine definition is global to the entire package in
which it's declared. Perl looks for subroutine definitions at compile-time, before actually
matter where the subroutine is declared even if it's declared in a conditional block that's never
reached during runtime when the program code is actually executed.
As an example, here is a small program with a subroutine definition:
#
# A program to demonstrate the global nature of subroutine definitions
#
my $dna = 'ACGT';
if ($dna eq 'ACGT') {
       print "This statement gets executed\n";
       print "Here's the subroutine call:\n";
       isdna($dna);
} else {
       print "This statement does not get executed\n";
       #
       # The following subroutine definition is in a block which is
       # never executed at runtime.
       #
       sub isdna {
               # Print the argument if it is DNA
               if($_[0] =~ /^[ACGT]+$/i) {
                       print $_[0], "\n";
               else {
                       return 0;
               }
       }
}
This produces the following output:
