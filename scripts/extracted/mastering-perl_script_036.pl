use strict; near the beginning of your program. However, it is
possible to use global variables that are not declared with my, which can be used anywhere in
a program, including within subroutines.
The statement:
my($concatenation);
declares another variable for use by the subroutine.
After the statement:
$concatenation = "$dna1$dna2";
statement:
return $concatenation;
example, it is given as the argument to the print function.
