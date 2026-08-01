#!/usr/bin/perl
# PROGRAM  : bptutorial.pl
# PURPOSE  : Demonstrate various uses of the bioperl package
# AUTHOR   : Peter Schattner schattner@alum.mit.edu
# CREATED  : Dec 15 2000
# REVISION : $Id: ch09.xml,v 1.2 2003/10/03 19:16:55 becki Exp chodacki $
use strict;
use Bio::SimpleAlign;
use Bio::AlignIO;
use Bio::SeqIO;
use Bio::Seq;
That seems like a good bet for a list of the most important Bioperl modules. Actually, some
other modules are loaded for individual demos; at various points, the following come into
play:
use Bio::SearchIO;
use Bio::Root::IO;
use Bio::MapIO;
use Bio::TreeIO;
use Bio::Perl
Following those use Module directives comes the following:
# subroutine references
my ($access_remote_db, $index_local_db, $fetch_local_db,
   $sequence_manipulations, $seqstats_and_seqwords,
   $restriction_and_sigcleave, $other_seq_utilities, $run_remoteblast,
   $run_standaloneblast,  $blast_parser, $bplite_parsing, $hmmer_parsing,
   $run_clustalw_tcoffee, $run_psw_bl2seq, $simplealign,
   $gene_prediction_parsing, $sequence_annotation, $largeseqs,
   $run_tree, $run_map, $run_struct, $run_perl, $searchio_parsing,
   $liveseqs, $demo_variations, $demo_xml, $display_help, $bpinspect1 );
# global variable file names.  Edit these if you want to try

#out a tutorial script on a different file
Bio::Root::IO->catfile("t","data","ecolitst.fa");
# used in $sequence_manipulations
my $dna_seq_file = Bio::Root::IO->catfile("t","data","dna1.fa");     
# used in $other_seq_utilities and in $run_perl and $sequence_annotation
my $amino_seq_file = Bio::Root::IO->catfile("t","data","cysprot1.fa"); 
# used in $blast_parser
my $blast_report_file = Bio::Root::IO->catfile("t","data","blast.report");  
# used in $bplite_parsing
my $bp_parse_file1 = Bio::Root::IO->catfile("t","data","blast.report");
# used in $bplite_parsing
my $bp_parse_file2 = Bio::Root::IO->catfile("t","data","psiblastreport.out");
# used in $bplite_parsing
my $bp_parse_file3 = Bio::Root::IO->catfile("t","data","bl2seq.out");       
# used in $run_clustalw_tcoffee
my $unaligned_amino_file = Bio::Root::IO->catfile("t","data","cysprot1a.fa");
# used in $simplealign
my $aligned_amino_file = Bio::Root::IO->catfile("t","data","testaln.pfam");
# other global variables
my (@runlist, $n );
$dna_seq_file. This method is there for portability between operating systems, because
operating systems each have their own syntax for specifying pathnames.
After that comes the code for the help screen, the output of which you've already seen; next
comes the individual demo subroutines; and finally the code for the main subroutine, which
you saw in the last section.
demos:
## "main" program follows
#no strict 'refs';
   @runlist = @ARGV;
   # display help if no option
   if (scalar(@runlist)=  =0) {&$display_help;};
   # argument = 0 means run tests 1 thru 22
   if ($runlist[0] =  = 0) {@runlist = (1..22); };
   foreach $n  (@runlist) {
       if ($n =  =100) {my $object = $runlist[1]; &$bpinspect1($object);
last;}
       if ($n =  =1) {&$sequence_manipulations; next;}
       if ($n =  =2) {&$seqstats_and_seqwords; next;}
       if ($n =  =3) {&$restriction_and_sigcleave; next;}
       if ($n =  =4) {&$other_seq_utilities; next;}
       if ($n =  =5) {&$run_perl; next;}
       if ($n =  =6) {&$searchio_parsing; next;}
       if ($n =  =7) {&$bplite_parsing; next;}
       if ($n =  =8) {&$hmmer_parsing; next;}
       if ($n =  =9) {&$simplealign ; next;}
       if ($n =  =10) {&$gene_prediction_parsing; next;}

       if ($n =  =11) {&$access_remote_db; next;}
       if ($n =  =12) {&$index_local_db; next;}
       if ($n =  =13) {&$fetch_local_db; next;}
       if ($n =  =14) {&$sequence_annotation; next;}
       if ($n =  =15) {&$largeseqs; next;}
       if ($n =  =16) {&$liveseqs; next;}
       if ($n =  =17) {&$run_struct; next;}
       if ($n =  =18) {&$demo_variations; next;}
       if ($n =  =19) {&$demo_xml; next;}
       if ($n =  =20) {&$run_tree; next;}
       if ($n =  =21) {&$run_map; next;}
       if ($n =  =22) {&$run_remoteblast; next;}
       if ($n =  =23) {&$run_standaloneblast; next;}
       if ($n =  =24) {&$run_clustalw_tcoffee; next;}
       if ($n =  =25) {&$run_psw_bl2seq; next;}
        &$display_help;
   }
## End of "main"
So, I searched for sequence_manipulation and found the following code for this, the first of
the bptutorial.pl demos:
#################################################
# sequence_manipulations  (  ):
#
$sequence_manipulations = sub {
   my ($infile, $in, $out, $seqobj);
   $infile = $dna_seq_file;
   print "\nBeginning sequence_manipulations and SeqIO example... \n";
   # III.3.1 Transforming sequence files (SeqIO)
   $in  = Bio::SeqIO->new('-file' => $infile ,
                          '-format' => 'Fasta');
   $seqobj = $in->next_seq(  );
   # perl "tied filehandle" syntax is available to SeqIO,
   # allowing you to use the standard <> and print operations
   # to read and write sequence objects, eg:
   #$out = Bio::SeqIO->newFh('-format' => 'EMBL');
   $out = Bio::SeqIO->newFh('-format' => 'fasta');
   print "First sequence in fasta format... \n";
   print $out $seqobj;
   # III.4 Manipulating individual sequences
   # The following methods return strings
   print "Seq object display id is ",
   $seqobj->display_id(  ), "\n"; # the human read-able id of the sequence
   print "Sequence is ",
   $seqobj->seq(  )," \n";        # string of sequence
   print "Sequence from 5 to 10 is ",
   $seqobj->subseq(5,10)," \n"; # part of the sequence as a string
   print "Acc num is ",
   $seqobj->accession_number(  ), " \n"; # when there, the accession number
   print "Moltype is ",

   $seqobj->alphabet(  ), " \n";    # one of 'dna','rna','protein'
   print "Primary id is ", $seqobj->primary_seq->primary_id(  )," \n";
   # a unique id for this sequence irregardless
   #print "Primary id is ", $seqobj->primary_id(  ), " \n";
   # a unique id for this sequence irregardless
   # of its display_id or accession number
   # The following methods return an array of  Bio::SeqFeature objects
   $seqobj->top_SeqFeatures; # The 'top level' sequence features
   $seqobj->all_SeqFeatures; # All sequence features, including sub
   # seq features
   # The following methods returns new sequence objects,
   # but do not transfer features across
   # truncation from 5 to 10 as new object
   print "Truncated Seq object sequence is ",
   $seqobj->trunc(5,10)->seq(  ), " \n";
   # reverse complements sequence
   print "Reverse complemented sequence 5 to 10  is ",
   $seqobj->trunc(5,10)->revcom->seq, "  \n";
   # translation of the sequence
   print "Translated sequence 6 to 15 is ",
   $seqobj->translate->subseq(6,15), " \n";
   my $c = shift;
   $c ||= 'ctgagaaaataa';
   print "\nBeginning 3-frame and alternate codon translation example...
\n";
   my $seq = new Bio::PrimarySeq('-SEQ' => $c,
                                 '-ID' => 'no.One');
   print "$c translated using method defaults   : ",
   $seq->translate->seq, "\n";
   # Bio::Seq uses same sequence methods as PrimarySeq
   my $seq2 = new Bio::Seq('-SEQ' => $c, '-ID' => 'no.Two');
   print "$c translated as a coding region (CDS): ",
   $seq2->translate(undef, undef, undef, undef, 1)->seq, "\n";
   print "\nTranslating in all six frames:\n";
   my @frames = (0, 1, 2);
   foreach my $frame (@frames) {
       print  " frame: ", $frame, " forward: ",
       $seq->translate(undef, undef, $frame)->seq, "\n";
       print  " frame: ", $frame, " reverse-complement: ",
       $seq->revcom->translate(undef, undef, $frame)->seq, "\n";
   }
   print "Translating with all codon tables using method defaults:\n";
   my @codontables = qw( 1 2 3 4 5 6 9 10 11 12 13 14 15 16 21 );
   foreach my $ct (@codontables) {
       print $ct, " : ",
       $seq->translate(undef, undef, undef, $ct)->seq, "\n";
   }
   return 1;
} ;
#################################################
[
Tea

m
LiB ]

9.7 bptutorial.pl: sequence_manipulation Demo
In this section, I'll go through the code for the demo subroutine sequence_manipulation that
was shown in the last section.
the scalar reference variable $sequence_manipulation:
$sequence_manipulations = sub {
...
}
passed in as arguments; this method uses no arguments but does occasionally use global
variables such as $dna_seq_file, which, as you've just seen, contain the pathname of the
input sequence file the demo will use:
my ($infile, $in, $out, $seqobj);
$infile = $dna_seq_file;
print "\nBeginning sequence_manipulations and SeqIO example... \n";
to the part of the document:
# III.3.1 Transforming sequence files (SeqIO)
which can be looked up in the table of contents to the document for further reading:
III.3 Manipulating sequences
III.3.1 Manipulating sequence data with Seq methods (Seq)
method:
# III.3.1 Transforming sequence files (SeqIO)
$in  = Bio::SeqIO->new('-file' => $infile ,'-format' => 'Fasta');
$seqobj = $in->next_seq(  );
# perl "tied filehandle" syntax is available to SeqIO,
# allowing you to use the standard <> and print operations
# to read and write sequence objects, eg:
#$out = Bio::SeqIO->newFh('-format' => 'EMBL');
$out = Bio::SeqIO->newFh('-format' => 'fasta');
print "First sequence in fasta format... \n";
print $out $seqobj;
method is being passed the pathname to a FASTA file in $infile, and told that the format is
FASTA.
A quick look at the Bio::SeqIO documentation explains that the call to Bio::SeqIO->new
returns a stream object for the specified format. So, $out is a stream object (a stream is
input or output of data) for FASTA-formatted data, and $in is a stream object for
FASTA-formatted input from the file named in the $infile variable. These $in and $out
objects are also filehandles.
After the $in object is initialized on the FASTA file named in $infile, it calls the next_seq
file, and it creates a sequence object $seqobj. The output $out object is created. The Perl

print statement is then called, using $out as a filehandle, and printing $seqobj. This prints
repeated here:
First sequence in fasta format... 
>Test1
AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTC
TGATAGCAGCTTCTGAACTGGTTACCTGCCGTGAGTAAATTAAAATTTTATTGACTTAGG
TCACTAAATACTTTAACCAATATAGGCATAGCGCACAGACAGATAAAAATTACAGAGTAC
ACAACATCCATGAAACGCATTAGCACCACC
extracting information from a sequence object:
# III.4 Manipulating individual sequences
# The following methods return strings
print "Seq object display id is ",
$seqobj->display_id(  ), "\n"; # the human read-able id of the sequence
print "Sequence is ",
$seqobj->seq(  )," \n";        # string of sequence
print "Sequence from 5 to 10 is ",
$seqobj->subseq(5,10)," \n"; # part of the sequence as a string
print "Acc num is ",
$seqobj->accession_number(  ), " \n"; # when there, the accession number
print "Moltype is ",
$seqobj->alphabet(  ), " \n";    # one of 'dna','rna','protein'
print "Primary id is ", $seqobj->primary_seq->primary_id(  )," \n";
# a unique id for this sequence irregardless
#print "Primary id is ", $seqobj->primary_id(  ), " \n";
# a unique id for this sequence irregardless
# of its display_id or accession number
# The following methods return an array of  Bio::SeqFeature objects
$seqobj->top_SeqFeatures; # The 'top level' sequence features
$seqobj->all_SeqFeatures; # All sequence features, including sub
# seq features
# The following methods returns new sequence objects,
# but do not transfer features across
# truncation from 5 to 10 as new object
print "Truncated Seq object sequence is ",
$seqobj->trunc(5,10)->seq(  ), " \n";
# reverse complements sequence
print "Reverse complemented sequence 5 to 10  is ",
$seqobj->trunc(5,10)->revcom->seq, "  \n";
# translation of the sequence
print "Translated sequence 6 to 15 is ",
$seqobj->translate->subseq(6,15), " \n";
of this book):
Seq object display id is Test1
Sequence is AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGA
TAGCAGCTTCTGAACTGGTTACCTGCCGTGAGTAAATTAAAATTTTATTGACTTAGGTCACTAAATACTTTAACC
AATATAGGCATAGCGCACAGACAGATAAAAATTACAGAGTACACAACATCCATGAAACGCATTAGCACCACC 
Sequence from 5 to 10 is TTTCAT 
Acc num is unknown 
Moltype is dna 
Primary id is Test1 
Truncated Seq object sequence is TTTCAT 
Reverse complemented sequence 5 to 10  is ATGAAA  
Translated sequence 6 to 15 is LQRAICLCVD
