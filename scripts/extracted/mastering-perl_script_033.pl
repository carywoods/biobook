use Bio::Perl;
        # will guess file format from extension
        $seq_object = read_sequence($filename);
        # forces genbank format
        $seq_object = read_sequence($filename,'genbank');
        # reads an array of sequences
        @seq_object_array = read_all_sequences($filename,'fasta');
        # sequences are Bio::Seq objects, so the following methods work
        # for more info see L<Bio::Seq>, or do 'perldoc Bio/Seq.pm'
        print "Sequence name is ",$seq_object->display_id,"\n";
        print "Sequence acc  is ",$seq_object->accession_number,"\n";
        print "First 5 bases is ",$seq_object->subseq(1,5),"\n";
        # get the whole sequence as a single string
        $sequence_as_a_string = $seq_object->seq(  );
        # writing sequences
        write_sequence(">$filename",'genbank',$seq_object);
        write_sequence(">$filename",'genbank',@seq_object_array);
        # making a new sequence from just strings you have
        # from something else
        $seq_object = new_sequence("ATTGGTTTGGGGACCCAATTTGTGTGTTATATGTA",
            "myname","AL12232");
        # getting a sequence from a database (assumes internet connection)
        $seq_object = get_sequence('swissprot',"ROA1_HUMAN");
        $seq_object = get_sequence('embl',"AI129902");
        $seq_object = get_sequence('genbank',"AI129902");
        # BLAST a sequence (assummes an internet connection)
        $blast_report = blast_sequence($seq_object);
        write_blast(">blast.out",$blast_report);
DESCRIPTION
      Easy first time access to BioPerl via functions

FEEDBACK
      Mailing Lists
      User feedback is an integral part of the evolution of this
      and other Bioperl modules. Send your comments and sugges-
      tions preferably to one of the Bioperl mailing lists.
      Your participation is much appreciated.
        bioperl-l@bio.perl.org
      Reporting Bugs
      Report bugs to the Bioperl bug tracking system to help us
      keep track the bugs and their resolution. Bug reports can
      be submitted via email or the web:
        bioperl-bugs@bio.perl.org
        http://bugzilla.bioperl.org/
AUTHOR - Ewan Birney
      Email bioperl-l@bio.perl.org
      Describe contact details here
APPENDIX
      The rest of the documentation details each of the object
      methods.  Internal methods are usually preceded with a _
...
that the code was not meant to be a running program. The variable $filename refers to
name is used in several other lines for different purposes. This is not an uncommon situation
can be run exactly as is).
strict and warnings pragmas and declared each variable with my. I created variables for the
input sequence files were on disk and of the correct variety (for example, I created the 
had this code:
use Bio::Perl;
use strict;
use warnings;
my $gbfilename = 'AI129902.genbank';
# will guess file format from extension
my $seq_object0 = read_sequence($gbfilename);
# forces genbank format
my $seq_object1 = read_sequence($gbfilename,'genbank');
my $fastafilename = 'array.fasta';
# reads an array of sequences
my @seq_object_array = read_all_sequences($fastafilename,'fasta');
# sequences are Bio::Seq objects, so the following methods work
# for more info see L<Bio::Seq>, or do 'perldoc Bio/Seq.pm'

print "Sequence name is ",$seq_object1->display_id,"\n";
print "Sequence acc  is ",$seq_object1->accession_number,"\n";
print "First 5 bases is ",$seq_object1->subseq(1,5),"\n";
# get the whole sequence as a single string
my $sequence_as_a_string = $seq_object1->seq(  );
# writing sequences
my $gbfilenameout = 'bpout.genbank';
write_sequence(">$gbfilenameout",'genbank',$seq_object1);
write_sequence(">$gbfilenameout",'genbank',@seq_object_array);
# making a new sequence from just strings you have
# from something else
my $seq_object2 = new_sequence("ATTGGTTTGGGGACCCAATTTGTGTGTTATATGTA",
   "myname","AL12232");
# getting a sequence from a database (assumes internet connection)
my $seq_object3 = get_sequence('swissprot',"ROA1_HUMAN");
my $seq_object4 = get_sequence('embl',"AI129902");
my $seq_object5 = get_sequence('genbank',"AI129902");
# BLAST a sequence (assummes an internet connection)
my $blast_report = blast_sequence($seq_object3);
write_blast(">blast.out",$blast_report);
test of my newly installed Bioperl modules was just to see if all the modules and methods
could be found and would run when called.
As mentioned previously, I also added use strict; and use warnings; and declared all the
last section.
So, I ran my slightly edited version of the example code from the beginning of the Bio::Perl
manpage, with the following results:
[tisdall]$ perl bp1.pl
Sequence name is AI129902
Sequence acc  is AI129902
First 5 bases is CTCCG
Submitted Blast for [ROA1_HUMAN] .........
[tisdall]$
-rw-rw-r--    1 tisdall  tisdall      2391 May  5 10:37 AI129902.genbank
-rw-rw-r--    1 tisdall  tisdall      2485 May  5 13:00 array.fasta

-rw-rw-r--    1 tisdall  tisdall      1513 May  5 13:02 bp1.pl
-rw-rw-r--    1 tisdall  tisdall      3653 May  5 13:02 bpout.genbank
-rw-rw-r--    1 tisdall  tisdall     56888 May  5 13:04 blast.out
sequence object $seq_object3. I discovered that trying to run the blast_sequence method
on a nucleotide sequence object (such as $seq_object5) failed. Although the documentation
for the method said that the sequence type would be examined and the appropriate BLAST
program called (for example, blastp for protein sequence and blastx for nucleotide
I had stored in $seq_object3. Perhaps this bug, a disconnect between the code and the
documentation, has been fixed by the time you read this.
[
Tea
m
LiB ]

9.4 Bioperl Problems
problems now.
a few example programs that you can run, as you'll soon see.
Other documentation for Bioperl is also available, including Internet-based tutorials,
improved.
it also means that, for the new user of Bioperl, an overview of the available resources is a
task in itself.
(more on that later).
bioinformatics.

9.5 Overview of Objects
standalone; others interact with each other in various ways.
of objects in Bioperl, collected in a few broadly defined groups.
Sequences
Bio::Seq is the main sequence object in Bioperl.
Bio::PrimarySeq is a sequence object without features.
Bio::SeqIO provides sequence file input and output.
Bio::Tools::SeqStats provides statistics on a sequence.
Bio::LiveSeq::* handles changing sequences.
Bio::Seq::LargeSeq provides support for very large sequences.
Databases
Bio::DB::GenBank provides GenBank access. Similar modules are available for several
biological databases.
Bio::Index::* indexing and accessing local databases.
Bio::Tools::Run::StandAloneBlast runs BLAST on your local computer.
Bio::Tools::Run::RemoteBlast runs BLAST remotely.
Bio::Tools::BPlite parses BLAST reports.
Bio::Tools::BPpsilite parses psiblast reports.
Bio::Tools::HMMER::Results parses HMMER hidden Markov model results.
Alignments
Bio::SimpleAlign manipulates and displays simple multiple sequence alignments.
Bio::UnivAln manipulates and displays multiple sequence alignments.
Bio::LocatableSeq are sequence objects with start and end points for locating
relative to other sequences or alignments.
Bio::Tools::pSW aligns two sequences with the Smith-Waterman algorithm.
Bio::Tools::BPbl2seq is a lightweight BLAST parser for pairwise sequence alignment
using the BLAST algorithm.
Bio::AlignIO also aligns two sequences with BLAST.
Bio::TCoffee is an interface to the TCoffee multiple sequence alignment package.
Bio::Variation::Allele handles sets of alleles.
Bio::Variation::SeqDiff handles sets of mutations and variants.
Features and genes on sequences
Bio::SeqFeature is the sequence feature object in Bioperl.
Bio::Tools::RestrictionEnzyme locates restriction sites in sequence.
Bio::Tools::Sigcleave finds amino acid cleavage sites.
Bio::Tools::OddCodes rewrites amino acid sequences in abbreviated codes for
Bio::Tools::SeqPattern provides support for regular expression descriptions of
sequence patterns.
Bio::LocationI provides an interface to location information for a sequence.
Bio::Location::Simple handles simple location information for a sequence, both as
a single location and as a range.
Bio::Location::Split provides location information where the location may
encompass multiple ranges, and even multiple sequences.
Bio::Location::Fuzzy provides location information that may be inexact.
Bio::Tools::Genscan is an interface to the gene finding program.
Bio::Tools::Sim4::Results (and Exon) is an interface to the gene exon finding
program.
