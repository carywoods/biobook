#!/usr/bin/perl
line, like so:
#!/usr/bin/perl -w
The -w flag turns on extra warnings. I prefer to do that with the line:
use warnings;
because it's more portable to different operating systems.
myprogram (or possibly ./myprogram or the full or relative pathname for the program) to
start the program running.
interpreter and gives it the program in the file to run.
This is just a shortcut for typing the following at the command line:
/usr/bin/perl myprogram

A.2 Comments
ignored by the Perl interpreter and is only there for programmers to read. A comment can
include any text.

A.3 Scalar Values and Scalar Variables
A.3.1 Strings
'This is a string in single quotes.'
or double quotes, such as:
"This is a string in double quotes."
commands such as \n to represent a newline (see Table A-3):
$aside = '(or so they say)';
$declaration = "Misery\n $aside \nloves company.";
print $declaration;
This snippet prints out:
Misery 
(or so they say) 
loves company.
A.3.2 Numbers
Numbers are scalar values that can be:

Integers:


-4

Floating-point (decimal):
4.5326

Scientific (exponential) notation (3.13 x 1023 or 313000000000000000000000):
3.13E23

Hexadecimal (base 16):
Ox12bc3

Octal (base 8):
O5777

Binary (base 2):
0b10101011
alone among computer languages in this regard):
if ( 10/3  == ( (1/3) * 10 ) {
   print "Success!";
}else {
   print "Failure!";
}
This prints:
