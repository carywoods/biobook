use strict;
my $PDB_Path = shift;
opendir ( INPUT_DIR, "$PDB_Path" )
or die "Error: Cannot read from mmCIF directory: '$PDB_Path'\n";
my @PDB_dir = readdir INPUT_DIR;
close INPUT_DIR;
my @PDB_Files = grep /\.pdb/, @PDB_dir;
foreach my $Current_PDB_File ( @PDB_Files )
{
my $Free_R;
my $Resolution;
open ( PDB_FILE, "$PDB_Path/$Current_PDB_File" )
or die "Cannot open PDB File: '$Current_PDB_File'\n";
while ( <PDB_FILE> )
{
if ( /^EXPDTA
/ and !/DIFFRACTION/ )
{
last;
}
if ( /^REMARK
2 RESOLUTION/ )
{
( undef, undef, undef, $Resolution ) = split ( " ", $_ );
}
if ( /^REMARK
FREE R VALUE
/ )
{
$Free_R = substr ( $_, 47, 6 );
$Free_R =~ s/ //g;
if ( $Free_R =~ /NULL/ or $Resolution eq "" )
{
last;
}
else
{
printf ( "%7s %4.2f %7.3f \n", $Current_PDB_File,
$Resolution, $Free_R );
last;
}
}
}
close ( PDB_FILE );
}

The Protein Databank
0.4
0.35
0.3
0.25
0.2
0.15
0.1
0.5
1.5
2.5
3.5
Resolution
Plot of Free R against resolution
Free R
Plotting free R values against resolution.
When executed against a directory containing PDB data-files, specified as a
command-line parameter, the free res program checks each data-file in turn as
looking for ''DIFFRACTION'' in the EXPDTA field. If there's no match, the program
to- parse'' format, using Perl's printf subroutine, the program checks to see if
both the $Free R and $Resolution scalar variables actually contain data. The
idea here is that the output from free res be redirected to a disk-file.
When Free R and Resolution are plotted against each other, they show a good
correlation of 0.666 (Pearson Correlation Coefficient). Figure 10.4 on page 186
presents the plot. This is an improvement on the poorer value of 0.36 between
the standard R value and Resolution as found by others. The reason for the
standard R factor, from poorer x-ray resolution data.
Database cross references
The DBREF subsection gives a list of cross references to other Bioinformatics
databases. This makes it easier for researchers to integrate biological datasets.
The present deposition policy of the PDB requires that all proteins longer than
ten residues should be cross referenced. This means that short peptides, which
may be synthetic, are excluded.