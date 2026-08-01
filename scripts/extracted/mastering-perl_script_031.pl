use Bio::Perl;
I ran it by putting it in a file bp0.pl and giving it to the Perl interpreter:
[tisdall]# perl bp0.pl
[tisdall]#
changed the module call of Bio::Perl to a call for the nonexistent module Bio::Perrl, I got
the following (slightly truncated) error output:
[tisdall@coltrane development]$ perl bp0.pl.broken
Can't locate Bio/Perrl.pm in @INC 
BEGIN failed--compilation aborted at bp0.pl.broken line 1.
typed at the command prompt:
perldoc bptutorial.pl
scripts" and created a file tut1.pl on my computer by pasting in the text of the first tutorial
script:
 use Bio::Perl;
 # this script will only work with an internet connection
 # on the computer it is run on
 $seq_object = get_sequence('swissprot',"ROA1_HUMAN");
 write_sequence(">roa1.fasta",'fasta',$seq_object);
I then ran the program and looked at the output file:
[tisdall]$ perl tut1.pl
[tisdall]$ cat roa1.fasta
>ROA1_HUMAN Heterogeneous nuclear ribonucleoprotein A1 (Helix-destabilizing
protein)
(Single-strand binding protein) (hnRNP core protein A1).
SKSESPKEPEQLRKLFIGGLSFETTDESLRSHFEQWGTLTDCVVMRDPNTKRSRGFGFVT
YATVEEVDAAMNARPHKVDGRVVEPKRAVSREDSQRPGAHLTVKKIFVGGIKEDTEEHHL
RDYFEQYGKIEVIEIMTDRGSGKKRGFAFVTFDDHDSVDKIVIQKYHTVNGHNCEVRKAL
SKQEMASASSSQRGRSGSGNFGGGRGGGFGGNDNFGRGGNFSGRGGFGGSRGGGGYGGSG
DGYNGFGNDGGYGGGGPGYSGGSRGYGSGGQGYGNQGSGYGGSGSYDSYNNGGGRGFGGG
SGSNFGGGGSYNDFGNYNNQSSNFGPMKGGNFGGRSSGPYGGGGQYFAKPRNQGGYGGSS
SSSSYGSGRRF
[tisdall]$
That seemed to work perfectly.
tut2.pl:

[tisdall]$ cat tut2.pl
use Bio::Perl;
# this script will only work with an internet connection
# on the computer it is run on
$seq_object = get_sequence('swissprot',"ROA1_HUMAN");
# uses the default database - nr in this case
$blast_result = blast_sequence($seq);
write_blast(">roa1.blast",$blast_report);
[tisdall]$ perl tut2.pl
-------------------- WARNING ---------------------
MSG: req was POST http://www.ncbi.nlm.nih.gov/blast/Blast.cgi
User-Agent: libwww-perl/5.69
Content-Length: 178
Content-Type: application/x-www-form-urlencoded
...
---------------------------------------------------
Submitted Blast for [blast-sequence-temp-id] 
[tisdall]$ cat roa1.blast
[tisdall]$ ls -l roa1.blast
-rw-rw-r--    1 tisdall  tisdall         0 Apr 30 11:28 roa1.blast
[tisdall]$
showed that it had 0 bytes in it.
and this is where it is failing. It's running (printing those ... dots took a while because the
program was waiting for a reply from NCBI over the Internet), but it's not printing out the
BLAST report to the file roa1.blast. What's going wrong?
I started my investigation by looking at the documentation for the Bio::Perl module by
typing:
perldoc Bio::Perl
and searching for the function that is failing, blast_sequence. Here's what I found:
blast_sequence
Title   : blast_sequence
Usage   : $blast_result = blast_sequence($seq)
          $blast_result = blast_sequence('MFVEGGTFASEDDDSASAEDE');
Function: If the computer has Internet accessibility, blasts
          the sequence using the NCBI BLAST server against nrdb.
          It choose the flavour of BLAST on the basis of the sequence.
          This function uses Bio::Tools::Run::RemoteBlast, which itself
          use Bio::SearchIO - as soon as you want to more, check out
          these modules
Returns : Bio::Search::Result::GenericResult.pm
