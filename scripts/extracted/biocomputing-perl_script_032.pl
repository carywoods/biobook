use strict;
use Bio::Perl;
use constant AMINO_COUNT
=>
92;
while ( my $ID = <> )

Introducing Bioperl
{
chomp( $ID );
print "Processing sequence: $ID.\n";
my $Org_Seq = read_sequence( "./seqs/$ID.swp", 'swiss' );
my $Protein_Code = $Org_Seq->subseq( 1, AMINO_COUNT );
my $Cropped_Seq = new_sequence( $Protein_Code, "$ID_CROPPED", $ID );
write_sequence( ">>MerAs_cropped.swp", 'swiss', $Cropped_Seq );
}
called MerAs cropped.swp, contains a set of concatenated SWISS-PROT records.
Here's an extract from the disk-file produced:
ID
MERA_ACICA_CROPPED
STANDARD;
PRT;
92 AA.
AC
MERA_ACICA;
DE
SQ
SEQUENCE
92 AA;
9363 MW;
F2AA11A3B589F55A CRC64;
MTTLKITGMT CDSCAAHVKE ALEKVPGVQS ALVSYPKGTA QLAIEAGTSS DALTTAVAGL
GYEATLADAP PTDNRAGLLD KMRGWIGAAD KP
//
ID
MERA_ALCSP_CROPPED
STANDARD;
PRT;
92 AA.
AC
MERA_ALCSP;
DE
SQ
SEQUENCE
92 AA;
9119 MW;
BD0F5CDA5FB699DC CRC64;
MYLNITGMTC DSCATHVKDA LEKVPGVLSA LVSYPKGSAQ LATDPGTSPE ALTAAVAGLG
.
.
.
Of course, this can also be accomplished using SRS to extract FASTA-formatted
entries, which can then be manually edited. Doing so (manually) shows that the
HMA domain is listed as the first 66 amino acids of the MerA proteins in the
annotation, not 92 as assumed, on the basis of the length of the MerP proteins.
Alternatively, change the AMINO COUNT constant from 92 to 66 in the Crop Seq.pl
program and re-run it. It should be clear that even for the simple sequence
processing tasks such as demonstrated above, the power of Bioperl is clear.
To produce an easy to upload disk-file, simply concatenate the MerP SWISS-
PROT protein disk-files with the pre-concatenated MerA fragments as stored in
the MerAs cropped.swp disk-file.
20.5
Remote BLAST Searches
One of the most useful and interesting sub-routines provided by Bioperl is
blast sequence. As its name implies, this sub-routine performs a sequence