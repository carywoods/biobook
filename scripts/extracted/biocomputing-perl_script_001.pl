use strict;
declared (or defined) before they are invoked.
Why do such a thing? Why restrict the programmer, when Perl is all about
freedom? The answer has to do with scale. As programs get bigger, they become
harder to maintain. The use of use strict helps keep things organised and
reduces the risk of errors being introduced into programs. And anything that
helps reduce errors is a good thing, even if it is sometimes inflexible. Think of
the use strict directive as a gentle reminder to take the time to limit the scope
of any variables used in a program. Thinking about the scope of variables, and
using my and our to control the visibility of variables, really becomes important
as a program grows in size.
When strictness is enabled, perl takes the time to check the declaration of
each of a program's variables before execution occurs. Consider this program,
called bestrict:
#! /usr/bin/perl -w
# bestrict - demonstrating the effect of strictness.
use strict;
$message = "This is the message.\n";
print $message;
variable. When an attempt is made to execute the bestrict program, perl
complains loudly that the strictness rules have been broken:
Global symbol "$message" requires explicit package name at bestrict line 7.
Global symbol "$message" requires explicit package name at bestrict line 9.
Execution of bestrict aborted due to compilation errors.
These ''compilation errors'' are fixed by simply declaring the $message scalar as
a my variable, thus:
my $message = "This is the message.\n";