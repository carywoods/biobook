use strict directive (as you are encouraged always to do).
Without use strict, the program fails only when it reaches that bad call. With use strict,
the program complains and fails immediately. What if that call isn't made until several hours

strict can save a lot of time and effort.
You can create an anonymous subroutine by giving the keyword sub followed by a subroutine
are not followed by a semicolon, as with the subroutine findmotif in the previous example.)
You can create a reference to the anonymous subroutine like so:
$findmotif = sub {
   my($input) = @_;
   if($input =~ /CCGA/) {
       print "I found CCGA!\n";
   }else{
       print "No motif\n";
   }
};
$findmotif->('ATTAATTTTCCGATC');
&$findmotif('ATTAATTTTCCGATC');
This gives the output:
I found CCGA!
I found CCGA!
In this case, $findmotif is a reference to an (anonymous) subroutine. The subroutine
reference was dereferenced and called twice to show the use of the two alternative choices
of syntax: the prepended ampersand and the arrow operator.
example illustrates:
@aminoacids1 = ('E', 'V', 'L');
@aminoacids2 = ('D', 'T', 'Y');
printacids(@aminoacids1, @aminoacids2);
sub printacids {
   my(@aa1, @aa2) = @_;
   print "Amino acids 1\n";
   print "@aa1\n";
   print "Amino acids 2\n";
   print "@aa2\n";
}
This prints out:
Amino acids 1
E V L D T Y
Amino acids 2
special array @_, and Perl assigns this entire array to the first local array @aa1.
example:

@aminoacids1 = ('E', 'V', 'L');
@aminoacids2 = ('D', 'T', 'Y');
printacids(\@aminoacids1, \@aminoacids2);
sub printacids {
   my($aa1, $aa2) = @_;
   print "Amino acids 1\n";
   print "@$aa1\n";
   print "Amino acids 2\n";
   print "@$aa2\n";
}
This prints out:
Amino acids 1
E V L
Amino acids 2
D T Y
references are collected in the variables $aa1 and $aa2 and are dereferenced to print out their
contents using the forms @$aa1 and @$aa2.
reference. Say you have the DNA sequence of human chromosome 1 in a variable $chrom1.
You want to pass this sequence into a subroutine that searches for restriction enzymes. A
problem can arise because passing a variable into a subroutine involves making a copy of the
computer's memory.
your program will use less memory. It will also run much faster because copying large strings
is a fairly time-consuming process for a program.
Here's a simple example of how to pass a scalar reference to a subroutine:
my $chrom1 = getchrom('1');  # assume we read in human chromosome 1 here
my @enzyme_sites = findrestrictionenzymes(\$chrom1, 'HindIII');
sub findrestrictionenzymes {
 my($seqref, $re) = @_; # $seqref is a reference to a scalar string
                        # $re contains the name of a restriction enzyme
 
 ... program logic follows, where $$seqref is the sequence data ...
}
this works; the bottom line is that a subroutine can return a reference because a reference is
"really" just a scalar value.

locations in computer memory.
For example, a hard reference to a scalar:
$name = 'Joel';
is defined like so:
$nameref = \$name;
and the values associated with the hard reference $$nameref are:
print '$nameref has the value ', $nameref, ' and points to the referent ', 
   $$nameref, "\n";
This prints:
$nameref has the value SCALAR(0x80fe4ac) and points to the referent Joel
four array variables @mark1, @mark2, @mark3, and @mark4. It is possible to have another
variable that is set to one of these variable names; let's say the variable is called $arrayname
and it's set to the value mark3, and that is the array we want to access.
You can place the $arrayname variable in a block. Because a block returns the value of its last
expression, this block returns the string mark3. You can then place the special array symbol @
in front of the block, and Perl will recognize this as meaning the @mark3 array. Here is a
demonstration of how this works:
@mark1 = ( 'a1', 'a2', 'a3', 'a4' );
@mark2 = ( 'b1', 'b2', 'b3', 'b4' );
@mark3 = ( 'c1', 'c2', 'c3', 'c4' );
@mark4 = ( 'd1', 'd2', 'd3', 'd4' );
$arrayname = 'mark3';
print "@{$arrayname}\n";
c1 c2 c3 c4
chapters.
[
Tea
m
LiB ]

2.3 Matrices
required, the matrix is n-dimensional.
identified by its particular row and column.
Because there is no built-in matrix data structure, you have to build a matrix from other data
structures. The most straightforward way to do this is with an array of arrays:
@probes = (
   [1, 3, 2, 9],
   [2, 0, 8, 1],
   [5, 4, 6, 7],
   [1, 9, 2, 8]
);
print "The probe at row 1, column 2 has value ", $probes[1][2], "\n";
This prints out:
The probe at row 1, column 2 has value 8
Recall that in Perl the first element of an array is indexed 0; so row 1 in
this program is actually the second row, and column 2 is actually the third
column. Sometimes you may want to refer to the 0th row as row 1; you
have to adjust your code and your interactions with the user accordingly.
to an anonymous array [in square brackets], which itself is a list of integers.
is, in effect, an anonymous array of anonymous arrays:
# Declare reference to (empty) anonymous array
$array = [  ];
# Initialize the array
for($i=0; $i < 4 ; ++$i) {
 for($j=0; $j < 4 ; ++$j) {
     $array->[$i][$j] = $i * $j;
 }
}
# Reset one of the elements of the array
$array->[3][2] = 99;
# Print the array
for($i=0; $i < 4 ; ++$i) {
 for($j=0; $j < 4 ; ++$j) {
     printf("%3d ", $array->[$i][$j]);
 }

 print "\n";
}
Note the use of printf to format the output nicely. For a refresher on
this Perl function, consult the Perl documentation, by typing:
perldoc -f printf
and
perldoc -f sprintf
at a shell prompt or check out http://www.perldoc.com.
 0   0   0   0 
 0   1   2   3 
 0   2   4   6 
 0   3  99   9
Alternatively, if the values are known, I can declare this as an anonymous array of
anonymous arrays by saying:
$array = [
 [0, 0, 0, 0], 
 [0, 1, 2, 3], 
 [0, 2, 4, 6], 
 [0, 3, 99, 9] 
];
I can also declare an array of anonymous arrays, by saying:
@array = (
 [0, 0, 0, 0], 
 [0, 1, 2, 3], 
 [0, 2, 4, 6], 
 [0, 3, 99, 9] 
);
Notice the slight syntactical difference between an array of anonymous arrays:
@array = ( [  ], [  ], ... );
and an anonymous array of anonymous arrays:
$array = [ [  ], [  ], ... ];
$$array[$i][$j]
as a synonym for:
$array->[$i][$j]
But beware confusing:
$array->[$i][$j]
with:
$array[$i][$j]
They are not the same thing and won't refer to the same array if you intermix them!
you have the following data:
 0   0   0   0 
 0   1   2   3 
 0   2   4   6 
 0   3  99   9
