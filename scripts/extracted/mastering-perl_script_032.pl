use strict and a use warnings into the
program and to declare variables with my to see what ensued:
[tisdall]$ cat tut2.pl
use Bio::Perl;
use strict;
use warnings;
# this script will only work with an internet connection
# on the computer it is run on
my $seq_object = get_sequence('swissprot',"ROA1_HUMAN");
# uses the default database - nr in this case
my $blast_result = blast_sequence($seq);
write_blast(">roa1.blast",$blast_report);
[tisdall]$ perl tut2.pl
Global symbol "$seq" requires explicit package name at tut2.pl line 11.
Global symbol "$blast_report" requires explicit package name at tut2.pl line
13.
Execution of tut2.pl aborted due to compilation errors.
[tisdall]$
Well, that's pretty clear. The variables $seq and $blast_report are wrong; apparently, the
author intended to reuse the variables $seq_object and $blast_result instead. So, I edited
the file and ran it again:
[tisdall]$ cat tut2.pl
use Bio::Perl;
use strict;
use warnings;
# this script will only work with an internet connection
# on the computer it is run on
my $seq_object = get_sequence('swissprot',"ROA1_HUMAN");
# uses the default database - nr in this case
my $blast_result = blast_sequence($seq_object);
write_blast(">roa1.blast",$blast_result);
[tisdall]$ perl tut2.pl
[tisdall]$ perl tut2.pl
Submitted Blast for [ROA1_HUMAN] ................... 
[tisdall]$ ls -l roa1.blast 
-rw-rw-r--    1 tisdall  tisdall     56888 May  5 15:05 roa1.blast
[tisdall]$
could use a little attention, clearly. By the time you're reading this, it may well have been
fixed.
