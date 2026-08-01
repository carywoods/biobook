use strict;
while ( <> )
{
if ( /^ATOM/ && substr( $_, 13, 4 ) eq "CA
" )
{
my ( $X, $Y, $Z ) = ( substr( $_, 30, 8 ),
substr( $_, 38, 8 ),
substr( $_, 46, 8 ) );
$X =~ s/ //g;
$Y =~ s/ //g;
$Z =~ s/ //g;

The Protein Databank
print "X, Y & Z: $X, $Y, $Z\n";
}
}
is of type carbon-alpha. When both tests pass, that is, the pattern is found and
the line represents a carbon-alpha atom, the X, Y and Z coordinates of the atom
are extracted from the line as a result of the three invocations of substr. The
resulting scalar variables ($X, $Y and $Z) have any spaces removed from them
in the three substitution statements. Finally, the coordinates are displayed on
STDOUT. When executed, the simple coord extract produces this output for the
X, Y & Z: 25.150, -8.702, 38.505
X, Y & Z: 23.675, -8.497, 35.069
X, Y & Z: 20.747, -6.252, 34.332
X, Y & Z: 17.545, -8.297, 34.292
X, Y & Z: 15.182, -7.484, 31.454
X, Y & Z: 11.736, -8.952, 30.942
X, Y & Z: 10.261, -9.014, 27.451
X, Y & Z:
6.507, -9.548, 27.173
Consequently, in the case of 1LQT, all of the coordinates for both the A and B
chains are displayed.
10.7
Contact Maps
The simple coord extract program is amended in this section to create a
Contact Map. In a contact map, the distances between all the amino acids are
calculated (using the standard Pythagoras equation), then those within a certain
distance of each other are marked with an ''O'' character. Those outside the
distance are marked with a space character.
One aspect to consider is whether this is computationally possible: is the
computer being asked to do too much? Calculating the distances between all
possible amino acids seems to be complicated. How many calculations need to be
performed? How much memory is needed? Will the program become much more
complicated?
Although consideration of these questions is reasonable, there is no need
to panic. Proteins at the level of abstraction of fixed 3D spatial coordinates
are computationally small. As there are 450 carbon-alpha atom points in the
test protein, there are 450 by 450 potential distance calculations, which gives
a total of 202,500. Although large, performing this number of calculations is