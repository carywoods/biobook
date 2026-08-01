#!/usr/bin/perl
use strict;
use warnings;
use lib "/home/tisdall/MasteringPerlBio/development/lib";
use FileIO;
my $obj = FileIO->new(  );
$obj->read(
 filename => 'file1.txt'
);
print "The file name is ", $obj->get_filename, "\n";
print "The contents of the file are:\n", $obj->get_filedata;
print "\nThe date of the file is ", $obj->get_date, "\n";
$obj->set_date('today');
print "The reset date of the file is ", $obj->get_date, "\n";
print "The write mode of the file is ", $obj->get_writemode, "\n";
print "\nResetting the data and filename\n";
my @newdata = ("line1\n", "line2\n");
$obj->set_filedata( \@newdata );

print "Writing a new file \"file2\"\n";
$obj->write(filename => 'file2');
print "Appending to the new file \"file2\"\n";
$obj->write(filename => 'file2', writemode => '>>');
print "Reading and printing the data from \"file2\":\n";
my $file2 = FileIO->new(  );
$file2->read(
 filename => 'file2'
);
print "The file name is ", $file2->get_filename, "\n";
print "The contents of the file are:\n", $file2->get_filedata;
I finally run the test program to get the following output:
The file name is file1.txt
The contents of the file are:
> sample dna  (This is a typical fasta header.)
agatggcggcgctgaggggtcttgggggctctaggccggccacctactgg
tttgcagcggagacgacgcatggggcctgcgcaataggagtacgctgcct
gggaggcgtgactagaagcggaagtagttgtgggcgcctttgcaaccgcc
tgggacgccgccgagtggtctgtgcaggttcgcgggtcgctggcgggggt
cgtgagggagtgcgccgggagcggagatatggagggagatggttcagacc
cagagcctccagatgccggggaggacagcaagtccgagaatggggagaat
acacctgagccactctcagatgaggaccta
The date of the file is Thu Dec  5 11:22:56 2002
The reset date of the file is today
The write mode of the file is >
Resetting the data and filename
Writing a new file "file2"
Appending to the new file "file2"
Reading and printing the data from "file2":
The file name is file2
The contents of the file are:
line1
line2
line1
line2
and writes files and provides a few options for the write mode.
can be extended relatively easily in a very useful direction.
So, next, I'll take my simple FileIO class and use it as a base class for a
bioinformatics-specific class.
[
Tea
m
