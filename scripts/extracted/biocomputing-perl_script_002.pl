use strict forces programmers
to place subroutines near the top of their programs. Something that ''forces''
To retain the flexibility of being able to place subroutines anywhere in a
program's disk-file, while still taking advantage of the use strict directive,
Perl provides the use subs directive that can be used in combination with use
strict to declare a list of subroutines at the top of a program. Subroutine
definitions can then appear anywhere in a program's disk-file. Here's an example:
use strict;
use subs qw( drawline biodb2mysql );
The use subs directive declares a list of subroutine names that are later defined
somewhere in the program's disk-file.
Although the Perl documentation advises the use of use strict for everything
but the most ''casual'' of programs, your authors' advice is, well, more strict:
always use use strict.
Maxim 8.1 Unless you have a really good reason not to,
always switch on strictness at the top of your program.
It is left as an exercise for the reader to think up a really good reason for not
using use strict.
8.3
Perl One-liners
Most of the example programs seen thus far in Bioinformatics, Biocomputing and
Perl start with the following line:
#! /usr/bin/perl -w
The -w switch is one of a large collection of directives that can be provided to
perl on the command-line3. The ''w'' stands for ''warnings'', and instructs perl
to warn the programmer when it notices any dubious programming practices

Perl Grabbag
(such as defining a subroutine twice). It is always a good idea to switch on
warnings, as it makes for better programs.
When discussing the installation of third-party CPAN modules during Chapter
5, the -e switch was used to check that the module had installed correctly, as
follows:
perl
-e
'use ExampleModule'
The ''e'' stands for ''execute'', and instructs perl to execute the program state-
ments included within the single quotes. Here's another example command-line:
perl
-e
'print "Hello from a Perl one-liner.\n";'
The ability to use the -e switch on the command-line in this way creates what's
known in the Perl world as a one-liner. That is, a single line of Perl code is
provided to perl to execute immediately from the command-line. Here's another
one-liner that turns perl into a simple command-line calculator:
perl
-e
'printf "%0.2f\n", 30000 * .12;'
which calculates 12% of 30,000 and displays the result (3600.00). The printf
subroutine is a variant of the more common print, and prints to a specified
format. Use these commands to learn more about printf and formats:
perldoc
-f
printf
perldoc
-f
sprintf
Another useful switch is -n, which, when used in combination with -e, treats the
one-liner as if it is enclosed with a loop. Consider this one-liner:
perl
-ne
'print if /ctgaatagcc/;'
embl.data
which is equivalent to the following program statements:
while ( <> )
{
print if /ctgaatagcc/;
}
That is, the code between the single quotes (the one-liner) is equivalent to
the above loop. The embl.data part of the command-line is just that: part of
the command-line, not part of the one-liner. When the one-liner is executed, the
following output is generated:
attgtaatat ctgaatagcc actgattttg taggcacctt tcagtccatc tagtgactaa