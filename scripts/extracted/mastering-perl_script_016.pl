use strict;
use warnings;
my(%genetic_code) = (
  
   'TCA' => 'S',    # Serine
   'TCC' => 'S',    # Serine
   'TCG' => 'S',    # Serine
   'TCT' => 'S',    # Serine
   'TTC' => 'F',    # Phenylalanine
   'TTT' => 'F',    # Phenylalanine
   'TTA' => 'L',    # Leucine
   'TTG' => 'L',    # Leucine
   'TAC' => 'Y',    # Tyrosine
   'TAT' => 'Y',    # Tyrosine
   'TAA' => '_',    # Stop
   'TAG' => '_',    # Stop
   'TGC' => 'C',    # Cysteine
   'TGT' => 'C',    # Cysteine
   'TGA' => '_',    # Stop
   'TGG' => 'W',    # Tryptophan
   'CTA' => 'L',    # Leucine
   'CTC' => 'L',    # Leucine
   'CTG' => 'L',    # Leucine
   'CTT' => 'L',    # Leucine
   'CCA' => 'P',    # Proline
   'CCC' => 'P',    # Proline
   'CCG' => 'P',    # Proline
   'CCT' => 'P',    # Proline
   'CAC' => 'H',    # Histidine
   'CAT' => 'H',    # Histidine
   'CAA' => 'Q',    # Glutamine
   'CAG' => 'Q',    # Glutamine
   'CGA' => 'R',    # Arginine
   'CGC' => 'R',    # Arginine
   'CGG' => 'R',    # Arginine
   'CGT' => 'R',    # Arginine
   'ATA' => 'I',    # Isoleucine
   'ATC' => 'I',    # Isoleucine

   'ATT' => 'I',    # Isoleucine
   'ATG' => 'M',    # Methionine
   'ACA' => 'T',    # Threonine
   'ACC' => 'T',    # Threonine
   'ACG' => 'T',    # Threonine
   'ACT' => 'T',    # Threonine
   'AAC' => 'N',    # Asparagine
   'AAT' => 'N',    # Asparagine
   'AAA' => 'K',    # Lysine
   'AAG' => 'K',    # Lysine
   'AGC' => 'S',    # Serine
   'AGT' => 'S',    # Serine
   'AGA' => 'R',    # Arginine
   'AGG' => 'R',    # Arginine
   'GTA' => 'V',    # Valine
   'GTC' => 'V',    # Valine
   'GTG' => 'V',    # Valine
   'GTT' => 'V',    # Valine
   'GCA' => 'A',    # Alanine
   'GCC' => 'A',    # Alanine
   'GCG' => 'A',    # Alanine
   'GCT' => 'A',    # Alanine
   'GAC' => 'D',    # Aspartic Acid
   'GAT' => 'D',    # Aspartic Acid
   'GAA' => 'E',    # Glutamic Acid
   'GAG' => 'E',    # Glutamic Acid
   'GGA' => 'G',    # Glycine
   'GGC' => 'G',    # Glycine
   'GGG' => 'G',    # Glycine
   'GGT' => 'G',    # Glycine
);
#
# codon2aa
#
# A subroutine to translate a DNA 3-character codon to an amino acid
#   Version 3, using hash lookup
sub codon2aa {
       my($codon) = @_;
       $codon = uc $codon;
       if(exists $genetic_code{$codon}) {
               return $genetic_code{$codon};
       }else{
               die "Bad codon '$codon'!!\n";
       }
}
1;
extension .pm.
The directives:
use strict;
use warnings;
will appear in all the code. The use strict directive enforces the use of the my directive for all
variables. The use warnings directive produces useful messages about potential problems in

in your program output, for instance. See the perldiag, perllexwarn, and perlmodlib
sections of the Perl manual.)
Finally, there is a subroutine definition for codon2aa. As an argument, this subroutine takes a
codon represented as a string of three DNA bases and returns the amino acid code
corresponding to the codon. It accomplishes this by a simple lookup in the hash 
%genetic_code and returns the result from the subroutine using the return built-in function.
codon. See the exercises at the end of this chapter for a discussion of the pros and cons of
this behavior.
In my earlier book, I defined the hash %genetic_code within the subroutine codon2aa. That
initialized when the Geneticcode.pm module is loaded by this statement:
use Geneticcode;
initialize it each time.
testGeneticcode and run by typing perl testGeneticcode:
use strict;
use warnings;
use lib "/home/tisdall/MasteringPerlBio/development/lib";
use Geneticcode;
my $dna = 'AACCTTCCTTCCGGAAGAGAG';
# Initialize variables
my $protein = '';
# Translate each three-base codon to an amino acid, and append to a protein 
for(my $i=0; $i < (length($dna) - 2) ; $i += 3) {
       $protein .= Geneticcode::codon2aa( substr($dna,$i,3) );
}
print $protein, "\n";
substr extracts from $dna the three characters beginning at the position given in the counter
variable $i; this three-character codon is then passed as the argument to the subroutine
codon2aa. This program produces the output:
NLPSGRE
Now, let's expand our Geneticcode module example. This new version of the module
from a Perl program that uses the module.

acids; others read sequence data from files and print it to the screen. This is a fairly obvious
division of functionality, so let's create two modules for this code. We'll expand the 
Here's the code for Geneticcode.pm:
package Geneticcode;
use strict;
use warnings;
my(%genetic_code) = (
   
   'TCA' => 'S',    # Serine
   'TCC' => 'S',    # Serine
   'TCG' => 'S',    # Serine
   'TCT' => 'S',    # Serine
   'TTC' => 'F',    # Phenylalanine
    ... as before ...
   'GAG' => 'E',    # Glutamic Acid
   'GGA' => 'G',    # Glycine
   'GGC' => 'G',    # Glycine
   'GGG' => 'G',    # Glycine
   'GGT' => 'G',    # Glycine
);
#
# codon2aa
#
# A subroutine to translate a DNA 3-character codon to an amino acid
#   Version 3, using hash lookup
sub codon2aa {
   my($codon) = @_;
   $codon = uc $codon;
   if(exists $genetic_code{$codon}) {
       return $genetic_code{$codon};
   }else{
           die "Bad codon '$codon'!!\n";
   }
}
#
# dna2peptide 
#
# A subroutine to translate DNA sequence into a peptide
sub dna2peptide {
   my($dna) = @_;
   # Initialize variables
   my $protein = '';

   # Translate each three-base codon to an amino acid, and append to a
protein 
   for(my $i=0; $i < (length($dna) - 2) ; $i += 3) {
       $protein .= codon2aa( substr($dna,$i,3) );
   }
   return $protein;
}
# translate_frame
#
# A subroutine to translate a frame of DNA
sub translate_frame {
   my($seq, $start, $end) = @_;
   my $protein;
   # To make the subroutine easier to use, you won't need to specify
   #  the end point-it will just go to the end of the sequence
   #  by default.
   unless($end) {
       $end = length($seq);
   }
   # Finally, calculate and return the translation
       return dna2peptide ( substr ( $seq, $start - 1, $end -$start + 1) );
}
1;
However, we also need to read sequence in from FASTA sequence files, and print out
sequence (the translated protein) to the screen. Because these needs are likely to recur in
many programs, it makes sense to make a separate module for just the file reading,
module; maybe there should be separate modules for each need? See the exercises at the
end of the chapter.)
Here's the code for the second module SequenceIO.pm, which handles reading from a file,
extracting FASTA sequence data, and printing sequence data:
package SequenceIO;
use strict;
use warnings;
# get_file_data
#
# A subroutine to get data from a file given its filename
sub get_file_data {
   my($filename) = @_;
   # Initialize variables
   my @filedata = (  );
   open(GET_FILE_DATA, $filename) or die "Cannot open file
'$filename':$!\n\n";
   @filedata = <GET_FILE_DATA>;

   close GET_FILE_DATA;
   return @filedata;
}
# extract_sequence_from_fasta_data
#
# A subroutine to extract FASTA sequence data from an array
sub extract_sequence_from_fasta_data {
   my(@fasta_file_data) = @_;
   # Declare and initialize variables
   my $sequence = '';
   foreach my $line (@fasta_file_data) {
       # discard blank line
       if ($line =~ /^\s*$/) {
           next;
       # discard comment line
       } elsif($line =~ /^\s*#/) {
           next;
       # discard fasta header line
       } elsif($line =~ /^>/) {
           next;
       # keep line, add to sequence string
       } else {
           $sequence .= $line;
       }
   }
   # remove non-sequence data (in this case, whitespace) from $sequence
string
   $sequence =~ s/\s//g;
   return $sequence;
}
# print_sequence
#
# A subroutine to format and print sequence data 
sub print_sequence {
   my($sequence, $length) = @_;
   # Print sequence in lines of $length
   for ( my $pos = 0 ; $pos < length($sequence) ; $pos += $length ) {
       print substr($sequence, $pos, $length), "\n";
   }
}
1;
Before we discuss the code, let's see a small program that uses it:
# Translate a DNA sequence into one of the six reading frames

use strict;
use warnings;
use lib "/home/tisdall/MasteringPerlBio/development/lib";
use Geneticcode;
use SequenceIO;
# Initialize variables
my @file_data = (  );
my $dna = '';
my $revcom = '';
my $protein = '';
# Read in the contents of the file "sample.dna"
@file_data = SequenceIO::get_file_data("sample.dna");
# Extract the sequence data from the contents of the file "sample.dna"
$dna = SequenceIO::extract_sequence_from_fasta_data(@file_data);
# Translate the DNA to protein in one of the six reading frames
#   and print the protein in lines 70 characters long
print "\n -------Reading Frame 1--------\n\n";
$protein = Geneticcode::translate_frame($dna, 1);
SequenceIO::print_sequence($protein, 70);
exit;
Here's the input file:
> sample dna  (This is a typical fasta header.)
agatggcggcgctgaggggtcttgggggctctaggccggccacctactgg
tttgcagcggagacgacgcatggggcctgcgcaataggagtacgctgcct
gggaggcgtgactagaagcggaagtagttgtgggcgcctttgcaaccgcc
tgggacgccgccgagtggtctgtgcaggttcgcgggtcgctggcgggggt
cgtgagggagtgcgccgggagcggagatatggagggagatggttcagacc
cagagcctccagatgccggggaggacagcaagtccgagaatggggagaat
gcgcccatctactgcatctgccgcaaaccggacatcaactgcttcatgat
cgggtgtgacaactgcaatgagtggttccatggggactgcatccggatca
ctgagaagatggccaaggccatccgggagtggtactgtcgggagtgcaga
gagaaagaccccaagctagagattcgctatcggcacaagaagtcacggga
gcgggatggcaatgagcgggacagcagtgagccccgggatgagggtggag
ggcgcaagaggcctgtccctgatccagacctgcagcgccgggcagggtca
gggacaggggttggggccatgcttgctcggggctctgcttcgccccacaa
atcctctccgcagcccttggtggccacacccagccagcatcaccagcagc
agcagcagcagatcaaacggtcagcccgcatgtgtggtgagtgtgaggca
tgtcggcgcactgaggactgtggtcactgtgatttctgtcgggacatgaa
gaagttcgggggccccaacaagatccggcagaagtgccggctgcgccagt
gccagctgcgggcccgggaatcgtacaagtacttcccttcctcgctctca
ccagtgacgccctcagagtccctgccaaggccccgccggccactgcccac
ccaacagcagccacagccatcacagaagttagggcgcatccgtgaagatg
agggggcagtggcgtcatcaacagtcaaggagcctcctgaggctacagcc
acacctgagccactctcagatgaggaccta
Here's the output of the program:
-------Reading Frame 1--------
RWRR_GVLGALGRPPTGLQRRRRMGPAQ_EYAAWEA_LEAEVVVGAFATAWDAAEWSVQVRGSLAGVVRE
CAGSGDMEGDGSDPEPPDAGEDSKSENGENAPIYCICRKPDINCFMIGCDNCNEWFHGDCIRITEKMAKA
IREWYCRECREKDPKLEIRYRHKKSRERDGNERDSSEPRDEGGGRKRPVPDPDLQRRAGSGTGVGAMLAR
GSASPHKSSPQPLVATPSQHHQQQQQQIKRSARMCGECEACRRTEDCGHCDFCRDMKKFGGPNKIRQKCR
LRQCQLRARESYKYFPSSLSPVTPSESLPRPRRPLPTQQQPQPSQKLGRIREDEGAVASSTVKEPPEATA

TPEPLSDEDL
A few comments are in order. First, the subroutines for translating codons are in the 
Geneticcode module. They include the hash %genetic_code and the subroutines codon2aa,
peptides. The subroutines for reading sequence data in from files, and for formatting and
get_file_data, extract_sequence_from_fasta_data, and print_sequence.
using modules.
[
Tea
m
LiB ]

1.8 Using Modules
to be the necessity to refer to subroutines in the modules with longer names!
There's a way to avoid lengthy module names and still use the short ones if you place a call
to the special Exporter module in the module code and modify the use MODULE declaration in
the calling code.
package Geneticcode;
and included the definition for the hash genetic_code and the subroutine codon2aa.
then use the convenient short names for things (e.g., codon2aa instead of
Exporter to see the whole story):
package Geneticcode;
require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(...);         # symbols to export on request
@EXPORT_OK = qw(codon2aa);    # symbols to export on request
The calling program then has to explicitly request the codon2aa symbol like so:
use Geneticcode qw(codon2aa);
If you use this approach, the calling program can just say:
codon2aa($codon);
instead of:
Geneticcode::codon2aa($codon);
object-oriented programming style of using modules doesn't use the Export facility, but it is a
exporting is also known as "polluting your namespace"), see the Perl documentation for the 
Exporter module (by typing perldoc Exporter at a command line or by going to the
http://www.perldoc.com web page).

1.9 CPAN Modules
on the Web, and you can use its modules for a variety of programming tasks.
some time to explore CPAN to see what goodies are available.
want your programs to do have already been programmed and are easily obtained in
in this section.
Second, all code on CPAN is free of charge and available for use by a very unrestrictive
copyright declaration. Sound good? Keep reading.
CPAN includes convenient ways to search for useful modules, and there's a CPAN.pm module
current version.
You can find more information by typing the following at the command line:
perldoc CPAN
Development Support
Operating System Interfaces
Networking Devices IPC
Data Type Utilities
Database Interfaces
User Interfaces
Language Interfaces
File Names Systems Locking
String Lang Text Proc
Opt Arg Param Proc
Internationalization Locale
Security and Encryption
World Wide Web HTML HTTP CGI
Server and Daemon Utilities
Archiving and Compression
Images Pixmaps Bitmaps
Mail and Usenet News
Control Flow Utilities
File Handle Input Output
Microsoft Windows Modules
Miscellaneous Modules
Commercial Software Interfaces
Not In Modulelist

perform some statistics and are looking for code that's already available. We'll go through the
steps necessary to search for the code, download and install it, and use the module in a
program.
At the main CPAN page, look for "searching" and click on search.cpan.org. If you search for
what you'll see:
1.  Statistics::Candidates
Statistics-MaxEntropy-0.9 - 26 Nov 1998 - Hugo WL ter Doest
2. Statistics::ChiSquare
How random is your data?
Statistics-ChiSquare-0.3 - 23 Nov 2001 - Jon Orwant
3. Statistics::Contingency
Calculate precision, recall, F1, accuracy, etc.
Statistics-Contingency-0.03 - 09 Aug 2002 - Ken Williams
4. Statistics::DEA
Discontiguous Exponential Averaging
Statistics-DEA-0.04 - 17 Aug 2002 - Jarkko Hietaniemi
5. Statistics::Descriptive
Module of basic descriptive statistical functions.
Statistics-Descriptive-2.4 - 26 Apr 1999 - Colin Kuskie
6. Statistics::Distributions
Perl module for calculating critical values of common statistical
distributions
Statistics-Distributions-0.07 - 22 Jun 2001 - Michael Kospach
7. Statistics::Frequency
simple counting of elements
Statistics-Frequency-0.02 - 24 Apr 2002 - Jarkko Hietaniemi
8. Statistics::GaussHelmert
General weighted least squares estimation
Statistics-GaussHelmert-0.05 - 18 Apr 2002 - Stephan Heuel
9. Statistics::LTU
An implementation of Linear Threshold Units
Statistics-LTU-2.8 - 27 Feb 1997 - Tom Fawcett
10. Statistics::Lite
Small stats stuff.
Statistics-Lite-1.02 - 15 Apr 2002 - Brian Lalonde 
11.  Statistics::MaxEntropy
Statistics-MaxEntropy-0.9 - 26 Nov 1998 - Hugo WL ter Doest
12. Statistics::OLS
perform ordinary least squares and associated statistics, v 0.07.
Statistics-OLS-0.07 - 13 Oct 2000 - Sanford Morton
13. Statistics::ROC
receiver-operator-characteristic (ROC) curves with nonparametric confidence
bounds
Statistics-ROC-0.01 - 22 Jul 1998 - Hans A. Kestler
14. Statistics::Regression

weighted linear regression package (line+plane fitting)
StatisticsRegression - 26 May 2001 - ivo welch
15. Statistics::SparseVector
Perl5 extension for manipulating sparse bitvectors
Statistics-MaxEntropy-0.9 - 26 Nov 1998 - Hugo WL ter Doest
16. Statistics::Descriptive::Discrete
Compute descriptive statistics for discrete data sets.
Statistics-Descriptive-Discrete-0.07 - 13 Jun 2002 - Rhet Turnbull
17. Bio::Tree::Statistics
Calculate certain statistics for a Tree
bioperl-1.0.2 - 16 Jul 2002 - Ewan Birney
18. Device::ISDN::OCLM::Statistics
OCLM statistics superclass
Device-ISDN-OCLM-0.40 - 02 Jan 2000 - Merlin Hughes
19. Device::ISDN::OCLM::CurrentStatistics
OCLM current call statistics
Device-ISDN-OCLM-0.40 - 02 Jan 2000 - Merlin Hughes
20. Device::ISDN::OCLM::ISDNStatistics
OCLM ISDN statistics
Device-ISDN-OCLM-0.40 - 02 Jan 2000 - Merlin Hughes 
21.  Device::ISDN::OCLM::Last10Statistics
OCLM Last10 call statistics
Device-ISDN-OCLM-0.40 - 02 Jan 2000 - Merlin Hughes
22. Device::ISDN::OCLM::LastStatistics
OCLM last call statistics
Device-ISDN-OCLM-0.40 - 02 Jan 2000 - Merlin Hughes
23. Device::ISDN::OCLM::ManualStatistics
OCLM manual call statistics
Device-ISDN-OCLM-0.40 - 02 Jan 2000 - Merlin Hughes
24. Device::ISDN::OCLM::SPStatistics
OCLM service provider statistics
Device-ISDN-OCLM-0.40 - 02 Jan 2000 - Merlin Hughes
25. Device::ISDN::OCLM::SystemStatistics
OCLM system statistics
Device-ISDN-OCLM-0.40 - 02 Jan 2000 - Merlin Hughes
Let's check out the Statistics::ChiSquare module.
information about the author.
definition part of the module:
package Statistics::ChiSquare;
# ChiSquare.pm
#
# Jon Orwant, orwant@media.mit.edu
#

# 31 Oct 95, revised Mon Oct 18 12:16:47 1999, and again November 2001
# to fix an off-by-one error
#
# Copyright 1995, 1999, 2001 Jon Orwant.  All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
# 
# Version 0.3.  Module list status is "Rdpf"
use strict;
use vars qw($VERSION @ISA @EXPORT);
require Exporter;
require AutoLoader;
@ISA = qw(Exporter AutoLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw(chisquare);
$VERSION = '0.3';
my @chilevels = (100, 99, 95, 90, 70, 50, 30, 10, 5, 1);
my %chitable = (  );
# assume the expected probability distribution is uniform
sub chisquare {
   my @data = @_;
   @data = @{$data[0]} if @data =  = 1 and ref($data[0]);
   my $degrees_of_freedom = scalar(@data) - 1;
   my ($chisquare, $num_samples, $expected, $i) = (0, 0, 0, 0);
   if (! exists($chitable{$degrees_of_freedom})) {
       return "I can't handle ", scalar(@data), 
       " choices without a better table.";
   }
   foreach (@data) { $num_samples += $_ }
   $expected = $num_samples / scalar(@data);
   return "There's no data!" unless $expected;
   foreach (@data) {
       $chisquare += (($_ - $expected) ** 2) / $expected;
   }
   foreach (@{$chitable{$degrees_of_freedom}}) {
       if ($chisquare < $_) {
           return
            "There's a <$chilevels[$i+1]% and <$chilevels[$i]% chance that
this data 
                   is random.";
       }
       $i++;
   }
   return "There's a <$chilevels[$#chilevels]% chance that this data is
random.";
}
$chitable{1} = [0.00016, 0.0039, 0.016, 0.15, 0.46, 1.07, 2.71, 3.84, 6.64];
$chitable{2} = [0.020,   0.10,   0.21,  0.71, 1.39, 2.41, 4.60, 5.99, 9.21];
$chitable{3} = [0.12,    0.35,   0.58,  1.42, 2.37, 3.67, 6.25, 7.82, 11.34];
$chitable{4} = [0.30,    0.71,   1.06,  2.20, 3.36, 4.88, 7.78, 9.49, 13.28];
$chitable{5} = [0.55,    1.14,   1.61,  3.00, 4.35, 6.06, 9.24, 11.07,
15.09];
$chitable{6} = [0.87,    1.64,   2.20,  3.83, 5.35, 7.23, 10.65, 12.59,
16.81];
$chitable{7} = [1.24,    2.17,   2.83,  4.67, 6.35, 8.38, 12.02, 14.07,

18.48];
$chitable{8} = [1.65,    2.73,   3.49,  5.53, 7.34, 9.52, 13.36, 15.51,
20.09];
$chitable{9} = [2.09,    3.33,   4.17, 6.39, 8.34, 10.66, 14.68, 16.92,
21.67];
$chitable{10} = [2.56,   3.94,   4.86, 7.27, 9.34, 11.78, 15.99, 18.31,
23.21];
$chitable{11} = [3.05,   4.58,  5.58, 8.15, 10.34, 12.90, 17.28, 19.68,
24.73];
$chitable{12} = [3.57,   5.23, 6.30, 9.03, 11.34, 14.01, 18.55, 21.03,
26.22];
$chitable{13} = [4.11,   5.89, 7.04, 9.93, 12.34, 15.12, 19.81, 22.36,
27.69];
$chitable{14} = [4.66,   6.57, 7.79, 10.82, 13.34, 16.22, 21.06, 23.69,
29.14];
$chitable{15} = [5.23,   7.26, 8.55, 11.72, 14.34, 17.32, 22.31, 25.00,
30.58];
$chitable{16} = [5.81,   7.96, 9.31, 12.62, 15.34, 18.42, 23.54, 26.30,
32.00];
$chitable{17} = [6.41,  8.67, 10.09, 13.53, 16.34, 19.51, 24.77, 27.59,
33.41];
$chitable{18} = [7.00,  9.39, 10.87, 14.44, 17.34, 20.60, 25.99, 28.87,
34.81];
$chitable{19} = [7.63, 10.12, 11.65, 15.35, 18.34, 21.69, 27.20, 30.14,
36.19];
$chitable{20} = [8.26, 10.85, 12.44, 16.27, 19.34, 22.78, 28.41, 31.41,
37.57];
1;
Some of this code will look familiar; some may not. Check out the use of package, use
strict, and require Exporter; they're parts of Perl you've just seen.
You'll also see references to version, Autoloader, use vars, and an initialization of a
makes sense.
the code very often. Usually you can just install the module, read enough of the
take that approach now.
installed Statistics::ChiSquare on my Linux computer using CPAN.pm.
modules:
How do I install Perl modules?
Installing a new module can be as simple as typing
perl -MCPAN -e 'install Chocolate::Belgian'.
The CPAN.pm documentation has more complete instructions on how to use
this convenient tool.  If you are uncomfortable with having something
take that much control over your software installation, or it otherwise
doesn't work for you, the perlmodinstall documentation covers
module installation for UNIX, Windows and Macintosh in more familiar terms.
