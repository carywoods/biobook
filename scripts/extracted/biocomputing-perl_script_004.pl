use strict;
my @sequences
= qw( gctacataat attgttttta aattatattc cgatgcttgg );
print "Before sorting:\n\t-> @sequences\n";
This print statement produces the following output:
Before sorting:
-> gctacataat attgttttta aattatattc cgatgcttgg
that is, the four short sequences are displayed in the order that they were
the @sequences array:
my @sorted = sort @sequences;
my @reversed = sort { $b cmp $a } @sequences;
my @also_reversed = reverse sort @sequences;
The first array, @sorted, is created as a result of invoking the in-built sort
subroutine, passing the @sequences array as its sole parameter. This sorts the
language can truly appreciate what a treat this actually is.

Perl Grabbag
@sequences array in Perl's default order, which is to sort alphabetically in
ascending order (from ''a'' through to ''z'').
The second array, @reversed, is also created as a result of invoking sort.
array. The small block of code on this line is:
{ $b cmp $a }
To understand this block of code, consider that the $a and $b scalars are special
scalars, reserved for use with sort. On the basis of the comparison operator
can customise the sort order. In this example, $b is being compared (cmp) to $a,
''a'').
The third array, @also reversed, is created by first sorting the @sequences
array (using the default sort order), then reversing the sorted list by invoking
the in-built reverse subroutine. Note that the reverse subroutine reverses the
lists created and assigned to arrays, they are printed to STDOUT using these
statements:
print "Sorted order (default):\n\t-> @sorted\n";
print "Reversed order (using sort { \$b cmp \$a }):\n\t-> @reversed\n";
print "Reversed order (using reverse sort):\n\t-> @also_reversed\n";
which results in the following output:
Sorted order (default):
-> aattatattc attgttttta cgatgcttgg gctacataat
Reversed order (using sort { $b cmp $a }):
-> gctacataat cgatgcttgg attgttttta aattatattc
Reversed order (using reverse sort):
-> gctacataat cgatgcttgg attgttttta aattatattc
various sort orders. Both the second and the third array (@reversed and
@also reversed) contain the same list of sorted elements.
It is also possible to sort in numerical order using sort. To demonstrate
the standard method of sorting in numerical order, the sortexamples program
defines a list of chromosome pair numbers and assigns them to another array,
called @chromosomes. The array is then printed to STDOUT:
my @chromosomes = qw( 17 5 13 21 1 2 22 15 );
print "Before sorting:\n\t-> @chromosomes\n";