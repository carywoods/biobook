#!/usr/bin/perl
use strict;
use warnings;
use lib "/home/tisdall/MasteringPerlBio/development/lib";
use SeqFileIO;
#
# First test basic FileIO operations
#  (plus filetype attribute)
#
my $obj = SeqFileIO->new(  );
$obj->read(
 filename => 'file1.txt'
);
print "The file name is ", $obj->get_filename, "\n";
print "The contents of the file are:\n", $obj->get_filedata;
print "\nThe date of the file is ", $obj->get_date, "\n";
print "The filetype of the file is ", $obj->get_filetype, "\n";
$obj->set_date('today');
print "The reset date of the file is ", $obj->get_date, "\n";
print "The write mode of the file is ", $obj->get_writemode, "\n";
print "\nResetting the data and filename\n";
my @newdata = ("line1\n", "line2\n");
$obj->set_filedata( \@newdata );
print "Writing a new file \"file2.txt\"\n";
$obj->write(filename => 'file2.txt');
print "Appending to the new file \"file2.txt\"\n";
$obj->write(filename => 'file2.txt', writemode => '>>');

print "Reading and printing the data from \"file2.txt\":\n";
my $file2 = SeqFileIO->new(  );
$file2->read(
 filename => 'file2.txt'
);
print "The file name is ", $file2->get_filename, "\n";
print "The contents of the file are:\n", $file2->get_filedata;
print "The filetype of the file is ", $file2->get_filetype, "\n";
print <<'HEADER';
##########################################
#
# Test file format recognizing and reading
#
##########################################
HEADER
my $genbank = SeqFileIO->new(  );
$genbank->read(
 filename => 'record.gb'
);
print "The file name is ", $genbank->get_filename, "\n";
print "\nThe date of the file is ", $genbank->get_date, "\n";
print "The filetype of the file is ", $genbank->get_filetype, "\n";
print "The contents of the file are:\n", $genbank->get_filedata;
print "\n####################\n####################\n####################\n";
my $raw = SeqFileIO->new(  );
$raw->read(
 filename => 'record.raw'
);
print "The file name is ", $raw->get_filename, "\n";
print "\nThe date of the file is ", $raw->get_date, "\n";
print "The filetype of the file is ", $raw->get_filetype, "\n";
print "The contents of the file are:\n", $raw->get_filedata;
print "\n####################\n####################\n####################\n";
my $embl = SeqFileIO->new(  );
$embl->read(
 filename => 'record.embl'
);
print "The file name is ", $embl->get_filename, "\n";
print "\nThe date of the file is ", $embl->get_date, "\n";
print "The filetype of the file is ", $embl->get_filetype, "\n";
print "The contents of the file are:\n", $embl->get_filedata;
print "\n####################\n####################\n####################\n";
my $fasta = SeqFileIO->new(  );
$fasta->read(
 filename => 'record.fasta'
);
print "The file name is ", $fasta->get_filename, "\n";
print "\nThe date of the file is ", $fasta->get_date, "\n";
print "The filetype of the file is ", $fasta->get_filetype, "\n";

print "The contents of the file are:\n", $fasta->get_filedata;
print "\n####################\n####################\n####################\n";
my $gcg = SeqFileIO->new(  );
$gcg->read(
 filename => 'record.gcg'
);
print "The file name is ", $gcg->get_filename, "\n";
print "\nThe date of the file is ", $gcg->get_date, "\n";
print "The filetype of the file is ", $gcg->get_filetype, "\n";
print "The contents of the file are:\n", $gcg->get_filedata;
print "\n####################\n####################\n####################\n";
my $staden = SeqFileIO->new(  );
$staden->read(
 filename => 'record.staden'
);
print "The file name is ", $staden->get_filename, "\n";
print "\nThe date of the file is ", $staden->get_date, "\n";
print "The filetype of the file is ", $staden->get_filetype, "\n";
print "The contents of the file are:\n", $staden->get_filedata;
print "\n####################\n####################\n####################\n";
print <<'REFORMAT';
##########################################
#
# Test file format reformatting and writing
#
##########################################
REFORMAT
print "At this point there are ", $staden->get_count, " objects.\n\n";
print "######\n###### Testing put methods\n######\n\n";
print "\nPrinting staden data in raw format:\n";
print $staden->put_raw;
print "\nPrinting staden data in embl format:\n";
print $staden->put_embl;
print "\nPrinting staden data in fasta format:\n";
print $staden->put_fasta;
print "\nPrinting staden data in gcg format:\n";
print $staden->put_gcg;
print "\nPrinting staden data in genbank format:\n";
print $staden->put_genbank;
print "\nPrinting staden data in PIR format:\n";
print $staden->put_pir;
web site, along with the rest of the programs for this book.

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
The filetype of the file is _fasta
The reset date of the file is today
The write mode of the file is >
Resetting the data and filename
Writing a new file "file2.txt"
Appending to the new file "file2.txt"
Reading and printing the data from "file2.txt":
The file name is file2.txt
The contents of the file are:
line1
line2
line1
line2
The filetype of the file is _unknown
##########################################
#
# Test file format recognizing and reading
#
##########################################
The file name is record.gb
The date of the file is Sun Mar 30 14:30:09 2003
The filetype of the file is _genbank
The contents of the file are:
LOCUS       AB031069     2487 bp    mRNA            PRI       27-MAY-2000
DEFINITION  Sequence severely truncated for demonstration.
ACCESSION   AB031069
VERSION     AB031069.1  GI:8100074
KEYWORDS    .
SOURCE      Homo sapiens embryo male lung fibroblast cell_line:HuS-L12 cDNA
to
           mRNA.
 ORGANISM  Homo sapiens
           Eukaryota; Metazoa; Chordata; Craniata; Vertebrata; Euteleostomi;
           Mammalia; Eutheria; Primates; Catarrhini; Hominidae; Homo.
REFERENCE   1  (sites)
 AUTHORS   Fujino,T., Hasegawa,M., Shibata,S., Kishimoto,T., Imai,Si. and
           Takano,T.
 TITLE     PCCX1, a novel DNA-binding protein with PHD finger and CXXC
domain,
           is regulated by proteolysis
 JOURNAL   Biochem. Biophys. Res. Commun. 271 (2), 305-310 (2000)
 MEDLINE   20261256
REFERENCE   2  (bases 1 to 2487)

 AUTHORS   Fujino,T., Hasegawa,M., Shibata,S., Kishimoto,T., Imai,S. and
           Takano,T.
 TITLE     Direct Submission
 JOURNAL   Submitted (15-AUG-1999) to the DDBJ/EMBL/GenBank databases.
           Tadahiro Fujino, Keio University School of Medicine, Department
of
           Microbiology; Shinanomachi 35, Shinjuku-ku, Tokyo 160-8582, Japan
           (E-mail:fujino@microb.med.keio.ac.jp,
           Tel:+81-3-3353-1211(ex.62692), Fax:+81-3-5360-1508)
FEATURES             Location/Qualifiers
    source          1..2487
                    /organism="Homo sapiens"
                    /db_xref="taxon:9606"
                    /sex="male"
                    /cell_line="HuS-L12"
                    /cell_type="lung fibroblast"
                    /dev_stage="embryo"
    gene            229..2199
                    /gene="PCCX1"
    CDS             229..2199
                    /gene="PCCX1"
                    /note="a nuclear protein carrying a PHD finger and a
CXXC
                    domain"
                    /codon_start=1
                    /product="protein containing CXXC domain 1"
                    /protein_id="BAA96307.1"
                    /db_xref="GI:8100075"
                   
/translation="MEGDGSDPEPPDAGEDSKSENGENAPIYCICRKPDINCFMIGCD
                   
NCNEWFHGDCIRITEKMAKAIREWYCRECREKDPKLEIRYRHKKSRERDGNERDSSEP
                   
RDEGGGRKRPVPDPDLQRRAGSGTGVGAMLARGSASPHKSSPQPLVATPSQHHQQQQQ
                   
QIKRSARMCGECEACRRTEDCGHCDFCRDMKKFGGPNKIRQKCRLRQCQLRARESYKY
                   
FPSSLSPVTPSESLPRPRRPLPTQQQPQPSQKLGRIREDEGAVASSTVKEPPEATATP
                   
EPLSDEDLPLDPDLYQDFCAGAFDDHGLPWMSDTEESPFLDPALRKRAVKVKHVKRRE
                   
KKSEKKKEERYKRHRQKQKHKDKWKHPERADAKDPASLPQCLGPGCVRPAQPSSKYCS
                   
DDCGMKLAANRIYEILPQRIQQWQQSPCIAEEHGKKLLERIRREQQSARTRLQEMERR
                   
FHELEAIILRAKQQAVREDEESNEGDSDDTDLQIFCVSCGHPINPRVALRHMERCYAK
                   
YESQTSFGSMYPTRIEGATRLFCDVYNPQSKTYCKRLQVLCPEHSRDPKVPADEVCGC
                   
PLVRDVFELTGDFCRLPKRQCNRHYCWEKLRRAEVDLERVRVWYKLDELFEQERNVRT
                    AMTNRAGLLALMLHQTIQHDPLTTDLRSSADR"
BASE COUNT      564 a    715 c    768 g    440 t
ORIGIN      
       1 agatggcggc gctgaggggt cttgggggct ctaggccggc cacctactgg tttgcagcgg
      61 agacgacgca tggggcctgc gcaataggag tacgctgcct gggaggcgtg actagaagcg
     121 gaagtagttg tgggcgcctt tgcaaccgcc tgggacgccg ccgagtggtc tgtgcaggtt
     181 cgcgggtcgc tggcgggggt cgtgagggag tgcgccggga gcggagatat ggagggagat
     241 aaaaaaaaaa aaaaaaaaaa aaaaaaa
//
####################
####################
####################
