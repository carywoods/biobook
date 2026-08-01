use strict;
use warnings;
my $rebase = Rebase->new(
   dbmfile => 'BIONET',
   bionetfile => 'bionet.212',
   mode => '0666',
);
my $restrict = Restrictionmap->new(
   rebase => $rebase,
   enzyme => 'EcoRI HindIII',  # GAATTC # AAGCTT
   sequence => 'ACGAATTCCGGAATTCG',
   graphictype => 'text',
);
print "Locations are ", join ' ', $restrict->get_enzyme_map('EcoRI'), "\n";
print $restrict->get_graphic;
## Some bigger sequence
my $biggerseq = SeqFileIO->new;
#$biggerseq->read(filename => 'map.fasta');
$biggerseq->read(filename => 'sampleecori.dna');
my $restrict2 = Restrictionmap->new(
   rebase => $rebase,
   enzyme => 'EcoRI HindIII',  # GAATTC # AAGCTT
   sequence => $biggerseq->get_sequence,
   graphictype => 'text',
);
print "\nHere is the map of the bigger sequence:\n\n";

print $restrict2->get_graphic;
Notice that a use lib directive is added to tell Perl where to find the modules; you can
argument to Perl.
Here's is the output from the test program:
Locations are 3 11 
 EcoRI   EcoRI  
ACGAATTCCGGAATTCG
AGATGGCGGCGCTGAGGGGTCTTGGGGGCTCTAGGCCGGCCACCTACTGG
TTTGCAGCGGAGACGACGCATGGGGCCTGCGCAATAGGAGTACGCTGCCT
                    EcoRI                        
GGGAGGCGTGACTAGAAGCGGGAATTCAAGTAGTTGTGGGCGCCTTTGCA
ACCGCCTGGGACGCCGCCGAGTGGTCTGTGCAGGTTCGCGGGTCGCTGGC
                                                 
        HindIII                                  
GGGGGTCGTAAGCTTGAGGGAGTGCGCCGGGAGCGGAGATATGGAGGGAG
ATGGTTCAGACCCAGAGCCTCCAGATGCCGGGGAGGACAGCAAGTCCGAG
                                                 
AATGGGGAGAATGCGCCCATCTACTGCATCTGCCGCAAACCGGACATCAA
                                                 
                     HindIII                     
CTGCTTCATGATCGGGTGTGACAAGCTTAACTGCAATGAGTGGTTCCATG
                                                 
GGGACTGCATCCGGATCAGCGGGATGGCAATGAGCGGGACAGCAGTGAGC
                                                 
CCCGGGATGAGGGTGGAGGGCGCAAGAGGCCTGTCCCTGATCCAGACCTG
                                                 
CAGCGCCGGGCAGGGTCAGGGACAGGGGTTGGGGCCATGCTTGCTCGGGG
                                                 
                                            EcoRI
CTCTGCTTCGCCCCACAAATCCTCTCCGCAGCCCTTGGTGGCCACGAATT                      
CACCCAGCCAGCATCACCAGCAGCAGCAGCAGCAGATCAAACGGTCAGCC
     EcoRI                                       
HindIII                                           
AAGCTTGAATTCCGCATGTGTGGTGAGTGTGAGGCACCAGTGACGCCCTC
                                                 
AGAGTCCCTGCCAAGGCCCCGCCGGCCACTGCCCACCCAACAGCAGCCAC
                                                 
                  EcoRI                          
AGCCATCACAGAAGTTAGGGAATTCGCGCATCCGTGAAGATGAGGGGGCA
                                                 
                              EcoRI              
GTGGCGTCATCAACAGTCAAGGAGCCTCCTGGAATTCAGGCTACAGCCAC
ACCTGAGCCACTCTCAGATGAGGACCTA
As you see, the sequence is printed out formatted for the page with the names of restriction
enzymes appearing above their recognition sites.
[
