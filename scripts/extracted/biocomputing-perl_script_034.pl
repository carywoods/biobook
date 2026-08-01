use Bio::SearchIO;
my $bls_report = shift;
my $in = new Bio::SearchIO( -format => 'blast',
-file
=> $bls_report );
while ( my $result = $in->next_result )
{
while( my $hit = $result->next_hit )
{
print "Hit = ", $hit->name, "\n";
}
}
After the usual first line, the switching on of strictness and the use of the
Bio::SearchIO module, the name of the disk-file as passed in on the command-
line is assigned to the $bls report scalar. This is then used to create a new
Bio::SearchIO object that is assigned to a scalar called $in. It is this scalar that
provides mechanisms to extract useful information from the BLAST output. In
this program, two while loops cycle through the BLAST data.
Here are the first ten lines of output produced by the above invocation of the
Blast parse.pl program:
Hit = sp|P00392|MERA_PSEAE
Hit = sp|P94702|MERA_ENTAG
Hit = sp|Q52109|MERA_ACICA
Hit = sp|P94188|MERA_ALCSP
Hit = sp|P08332|MERA_SHIFL
Hit = sp|Q51772|MERA_PSEFL
Hit = sp|P17239|MERA_THIFE
Hit = sp|Q54465|MERA_SHEPU
Hit = sp||P08662_1
Hit = sp|P30341|MERA_STRLI
To learn more about the Bio::SearchIO module, use this command-line to view
its documentation:
perldoc
Bio/SearchIO.pm
The documentation is quite involved and provides details on the extensive
features of the module. For example, it is a straightforward matter to extract
individual alignments or convert BLAST output into HTML.
Where to from Here
Bioperl is a flexible, extensive, powerful and standard set of Bioinformatics
analysis and control modules for Perl programmers. This chapter touches on a

Introducing Bioperl
very small part of Bioperl. There are lots more, including excellent modules for
and bioscience in general. The real power of Bioperl comes from the external
packages that it presents, in that they are neat, clean interfaces. This allows
programmers to incorporate sophisticated functionality into their own programs
without too much difficulty.
Readers are encouraged to take as much time as necessary to learn about the
extensive features provided by the Bioperl modules. Feel free to get involved in
working for the project, too. Volunteers are always welcome!
The Maxims Repeated
Here's a list of the maxims introduced in this chapter.
# Don't reinvent the wheel. Use Bioperl whenever possible.
# Combine Bioperl with other tools to get your work done.
Exercises
1. Download, install and configure Bioperl onto your computer. Take the time
to explore its many features.