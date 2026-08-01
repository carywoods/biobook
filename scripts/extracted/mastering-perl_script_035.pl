use strict;
use warnings;
my $a;
my $b;
$b = $a + 2;
produces the warning output:
Use of uninitialized value in addition (+) at - line 5.
You can test for defined and undefined values with the Perl function defined.
A.12.2 Logical Operators
There are four logical operators: 
not
and
or
xor
not turns true values into false and false values into true. Its use is best illustrated in
code:
if(not $done) {...}
This executes the code only if $done is false.
and is a binary operator that returns true if both its operands are true. If one or both of the
operands are false, the operator returns false:
1   and  1    returns true
'a' and  ''   returns false
''  and  0    returns false
or is a binary operator that returns true if one or both of the operands are true. If both
operands are false, it returns false:
1   or  1    returns true
'a' or  ''   returns true
''  or  0    returns false
xor, or exclusive-OR, returns true if one operand is true and the other operand is false;

xor returns false if both operands are true or if both operands are false:
1 xor 0   returns true
0 xor 1   returns true
1 xor 1   returns false
0 xor 0   returns false
There are also variants on most of these:
! for not
&& for and
|| for or 
may only have:
!
||
&& 
instead of not or and.
A.12.3 Using Logical Operators for Control Flow
programs to see the following statement to open a file:
open(FH, $filename) or die "Cannot open file $filename: $!";
The use of or in this statement shows another important thing about the binary logical
operators: they evaluate their arguments left to right. In this case, if the open succeeds, the
program with the message in the string, plus additional messages if $! is included). The or
never bothers, because if one operand is true, the or is true, so it doesn't need to check the
second operand. However, if the open fails, the or needs to check that the second operand
is true or false, so it goes ahead and executes the die statement.
You can use the and statement similarly to test the second operand only if the first operand
succeeds.
xor doesn't work for control flow, because both its arguments have to be evaluated each
time.
I haven't used this chaining of logical operators much; instead, I've used if statements. This
is because I often find that I want to add more statements following a test, and it's easier if
the original is written as an if statement with a block, and it's harder if the original is written
as a logical operator.
A.12.4 The if Statement
Conditional tests are commonly found in if statements and in their variants and loops. Here's
an example of an if statement:
if (open (FH, $filename) {
   print "Hurray, I opened the file.";
}
The if statement is followed by a conditional expression enclosed in parentheses, which is
true, the statements in the block are executed.
The if statement may optionally be followed by an else, which is executed when the
conditional evaluates to false:
if ( open(FH, $filename) {

   print "Hurray, I opened the file.";
} else {
   print "Rats. The file did not open.";
}
The if statement may also optionally include any number of elsif clauses, which check
additional conditional statements if none of the preceding conditional statements are true:
if ( open(FH, $file1) {
   print "Hurray, I opened file 1.";
} elsif ( open(FH, $file2) {
   print "Hurray, I opened file 2.";
} elsif ( open(FH, $file3) {
   print "Hurray, I opened file 3.";
} else {
   print "None of the dadblasted files would open.";
}
In the preceding example, if file 1 opened successfully, the if statement doesn't try to open
additional files.
There is also an unless statement, which is the same as an if statement with the conditional
negated. So these two statements are equivalent:
unless ( open(FH, $filename) {
   print "Rats. The file did not open.";
}
if ( not open(FH, $filename) {
   print "Rats. The file did not open.";
}
[
Tea
m
LiB ]

A.13 Binding Operators
Binding operators are used for pattern matching, substitution, and transliteration on strings.
They are used with regular expressions that specify the patterns:
'ACGTACGTACGTACGT' =~ /CTA/
tells the program which string to search, returning true if the pattern appears in the string.
!~ is another string binding operator; it returns true if the pattern isn't in the string:
'ACGTACGTACGTACGT' !~ /CTA/
This is equivalent to:
not 'ACGTACGTACGTACGT' =~ /CTA/
You can substitute one pattern for another using the string binding operator. In the next
of thine with the string nine:
$poor_richard = 'A stitch in time saves thine.';
$poor_richard =~ s/thine/nine/;
print $poor_richard;
This produces the output:
A stitch in time saves nine.
A 
T, C 
G, G 
C, and T 
A:
$DNA = 'ACGTTTAA';
$DNA =~ tr/ACGT/TGCA/;
This produces the value:
TGCAAATT
example which counts the number of Gs in a string of DNA sequence data:
$DNA = 'ACGTTTAA';
$count = ($DNA =~ tr/A//);
print $count;
translations made in a string, which is then assigned to the variable $count.

A.14 Loops
There are several forms of loops in Perl:
while(CONDITION) {BLOCK}
until(CONDITION) {BLOCK}
for(INITIALIZATION ; CONDITION ; RE-INITIALIZATION ) {BLOCK}
foreach VAR (LIST) {BLOCK}
for VAR (LIST) {BLOCK}
do {BLOCK} while (CONDITION)
do {BLOCK} until (CONDITION)
The while loop first tests if the conditional is true; if so, it executes the block and then
over:
$i = 3;
while ( $i ) {
   print "$i\n";
   $i--;
}
This produces the output:
Here's how the loop works. The scalar variable $i is first initialized to 3 (this isn't part of the
loop). The loop is then entered, and $i is tested to see if it has a true (nonzero) value. It
does, so the number 3 is printed, and the decrement operator is applied to $i, which reduces
test of $i, which is now the true value 1; 1 is printed and decremented to 0. The loop starts
again; 0 is tested to see if it's true, and it's not, so the loop is now finished.
variable.
The for loop makes this easy by including the variable initialization and the variable change in
produces the same output:
for ( $i = 3 ; $i ; $i-- ) {
   print "$i\n";
}
example:
@array = ('one', 'two', 'three');
foreach $element (@array) {
   print $element\n";
}
This prints the output:
one
two
three
