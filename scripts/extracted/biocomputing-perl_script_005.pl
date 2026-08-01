use strict;
to know has already been covered in Bioinformatics, Biocomputing and Perl.

Perl Grabbag
my @the_file;
while ( <> )
{
chomp;
push @the_file, $_;
}
my @sorted_file = sort @the_file;
foreach my $line ( @sorted_file )
{
print "$line\n";
}
Given a disk-file, called sort.data, with the following contents:
Zap!
Zoom!
Bang!
Bam!
Batman, look out!
Robin, behind you!
Aaaaah, it's the Riddler!
perl
sortfile
sort.data
and produces the following output:
Aaaaah, it's the Riddler!
Batman, look out!
Robin, behind you!
Zap!
Zoom!
Bang!
Bam!
Of course, the savvy Linux user would use the sort utility to do the same thing,
using this command-line:
sort
sort.data
required in creating a custom program can be avoided when the operating system
utilities are used instead.
Maxim 8.3 Take the time to become familiar with
the utilities included in the operating system.
Refer to the Suggestions for Further Reading appendix (page 461) for some
advice on learning more about the utilities included with Linux. A short list of
Commands, beginning on page 467. Use this command-line to learn more about
the sort utility:
man
sort

HERE Documents
8.7
HERE Documents
Consider the requirement to display the following text on screen in exactly the
format shown from within a program:
Shotgun Sequencing
This is a relatively simple method of reading
a genome sequence.
It is ''simple'' because
it does away with the need to locate
individual DNA fragments on a map before
they are sequenced.
The Shotgun Sequencing method relies on
powerful computers to assemble the finished
sequence.
Utilising the Perl features already known, a sequence of print statements would
do the trick, as follows:
print "Shotgun Sequencing\n\n";
print "This is a relatively simple method of reading\n";
print "a genome sequence.
It is ''simple'' because\n";
print "it does away with the need to locate\n";
print "individual DNA fragments on a map before\n";
print "they are sequenced.\n\n";
print "The Shotgun Sequencing method relies on\n";
print "powerful computers to assemble the finished\n";
print "sequence.\n";
By enclosing each line in double quotes and appending the appropriate number
of newlines to the end of each line, the above sequence of print statements
better way to do this using Perl's HERE document mechanism. Rather than try to
describe what a HERE document is, let's look at an example:
my $shotgun_message = <<ENDSHOTMSG;
Shotgun Sequencing
This is a relatively simple method of reading
a genome sequence.
It is ''simple'' because
it does away with the need to locate
individual DNA fragments on a map before
they are sequenced.
The Shotgun Sequencing method relies on
powerful computers to assemble the finished

Perl Grabbag
sequence.
ENDSHOTMSG
print $shotgun_message;
The above code assigns a HERE document to the $shotgun message scalar. The
HERE document starts with the << chevrons, which has a programmer-chosen
identifier (written in uppercase by convention) attached to it. Note that there
Everything between the identifier and the repetition of the identifier is the HERE
document. This means that the message describing Shotgun Sequencing is a HERE
document assigned to the $shotgun message scalar. It is then printed to STDOUT
using a simple print statement.
Of note is the fact that the HERE document does not need to include all
those newlines, as was the case above with the sequence of print statements. In
addition, the double quotes surrounding each string are also missing from the
HERE document. All that programmers using the HERE document have to worry
improve upon the HERE document example above by removing the need for the
$shotgun message scalar and printing the HERE document directly, as follows:
print <<ENDSHOTMSG;
Shotgun Sequencing
This is a relatively simple method of reading
a genome sequence.
It is ''simple'' because
it does away with the need to locate
individual DNA fragments on a map before
they are sequenced.
The Shotgun Sequencing method relies on
powerful computers to assemble the finished
sequence.
ENDSHOTMSG
HERE documents are surprisingly useful, especially when it comes to dynamically
producing HTML documents. This use of HERE documents is discussed later in
the Working with the Web part of Bioinformatics, Biocomputing and Perl.
Where to from Here
This chapter ends Part I, Working with Perl. Readers who worked through this
and the preceding five chapters now know enough Perl to confidently perform a
variety of programming tasks. The remainder of this book builds upon this base
and applies what has been learnt about Perl to a number of Bioinformatics tasks.