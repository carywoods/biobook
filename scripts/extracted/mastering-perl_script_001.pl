#!/usr/bin/perl
#
# Approximate string matching using dynamic programming
#
#   Find the closest match to the pattern in the text
#
use strict;
use warnings;
my $pattern = 'EIQADEVRL';
print "PATTERN:\n$pattern\n";
my $text = 'SVLQDRSMPHQEILAADEVLQESEMRQQDMISHDE';
print "TEXT:\n$text\n";
my $TLEN = length $text;
my $PLEN = length $pattern;
# D is the Distance matrix, which shows the "edit distance" between
# substrings of the pattern and the text.
# It is implemented as a reference to an anonymous array.
my $D = [  ];
# The rows correspond to the text
# Initialize row 0 of D.
for (my $t=0; $t <= $TLEN ; ++$t) {
   $D->[$t][0] = 0;

}
# The columns correspond to the pattern
# Initialize column 0 of D.
for (my $p=0; $p <= $PLEN ; ++$p) {
   $D->[0][$p] = $p;
}
# Compute the edit distances.
for (my $t=1; $t <= $TLEN ; ++$t) {
   for (my $p=1; $p <= $PLEN ; ++$p) {
       $D->[$t][$p] =
       # Choose whichever of the three alternatives has the least cost
       min3(
           # First alternative
           # The text and pattern may or may not match at this character ...
           substr($text, $t-1, 1) eq substr($pattern, $p-1, 1) 
           ? $D->[$t-1][$p-1]  # If they match, no increase in edit
distance!
           :  $D->[$t-1][$p-1] + 1,
           # Second alternative
           # If the text is missing a character
           $D->[$t-1][$p] + 1,
           # Third alternative
           # If the pattern is missing a character
           $D->[$t][$p-1] + 1
       )
   }
}
# Print D, the resulting edit distance array
for (my $p=0; $p <= $PLEN ; ++$p) {
   for (my $t=0; $t <= $TLEN ; ++$t) {
       print $D->[$t][$p], " ";
   }
   print "\n";
}
my @matches = (  );
my $bestscore = 10000000;
# Find the best match(es).
# The edit distances appear in the the last row.
for (my $t=1 ; $t <= $TLEN ; ++$t) {
   if( $D->[$t][$PLEN] < $bestscore) {
       $bestscore = $D->[$t][$PLEN];
       @matches = ($t);
   }elsif( $D->[$t][$PLEN] =  = $bestscore) {
       push(@matches, $t);
   }
}
   
# Report the best match(es).
print "\nThe best match for the pattern $pattern\n";
print "has an edit distance of $bestscore\n";
print "and appears in the text ending at location";
print "s" if ( @matches > 1);
print " @matches\n";
   

sub min3 {
   my($i, $j, $k) = @_;
   my($tmp);
   $tmp = ($i < $j ? $i : $j);
   $tmp < $k ? $tmp : $k;
}
PATTERN:
EIQADEVRL
TEXT:
SVLQDRSMPHQEILAADEVLQESEMRQQDMISHDE
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
1 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 0 1 1 1 0 1 0 1 1 1 1 1 1 1 1 1 1 0 
2 2 2 2 2 2 2 2 2 2 2 2 1 0 1 2 2 2 1 1 2 2 1 1 1 1 2 2 2 2 2 1 2 2 2 1 
3 3 3 3 2 3 3 3 3 3 3 2 2 1 1 2 3 3 2 2 2 2 2 2 2 2 2 2 2 3 3 2 2 3 3 2 
4 4 4 4 3 3 4 4 4 4 4 3 3 2 2 1 2 3 3 3 3 3 3 3 3 3 3 3 3 3 4 3 3 3 4 3 
5 5 5 5 4 3 4 5 5 5 5 4 4 3 3 2 2 2 3 4 4 4 4 4 4 4 4 4 4 3 4 4 4 4 3 4 
6 6 6 6 5 4 4 5 6 6 6 5 4 4 4 3 3 3 2 3 4 5 4 5 4 5 5 5 5 4 4 5 5 5 4 3 
7 7 6 7 6 5 5 5 6 7 7 6 5 5 5 4 4 4 3 2 3 4 5 5 5 5 6 6 6 5 5 5 6 6 5 4 
8 8 7 7 7 6 5 6 6 7 8 7 6 6 6 5 5 5 4 3 3 4 5 6 6 6 5 6 7 6 6 6 6 7 6 5 
9 9 8 7 8 7 6 6 7 7 8 8 7 7 6 6 6 6 5 4 3 4 5 6 7 7 6 6 7 7 7 7 7 7 7 6 
The best match for the pattern EIQADEVRL
has an edit distance of 3
and appears in the text ending at location 20
purely for didactic purposes: I want to show the entire matrix that is computed. To see how it
searching for a 20 basepair oligonucleotide. (You'll probably want to omit the printing of the
matrix in this case!)
Because our program needs to refer to the lengths of the pattern and text at several points,
we precompute them to save time and to make the code easier to read. ($PLEN is easier to
read in those tightly packed loops than length $pattern.)
Next, the array D is declared:
my $D = [  ];
$D refers to the anonymous array denoted by [ ]. It is populated as the algorithm
progresses, as a two-dimensional array of integers.
The code for the calculation of the edit distance array $D is very short. The 0th row and the
the 0th column is initialized to 0, 1, 2, ... up to PLEN.
Why? Let's talk about how this algorithm is going to work.
pattern and a substring of the text. To be more precise: consider the entry of $D at row $t
and column $p (we'll call it in actual Perl syntax $D->[$t][$p]). The value of $D at this
position represents the edit distance between the prefix of the pattern of length $p, and a
substring of the text ending at text position $t.
again, with the input strings lined up with the rows and columns.
