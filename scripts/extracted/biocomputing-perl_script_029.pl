use strict;
my $start;
my $end;
my $Image_Size_X;
my $Image_Size_Y = 600;
my $line_width = 20;
my @Features;
while ( <> )
{
chomp;
compression reduces the disk-file produced to less than 19,000 bytes.
it's '/t' directory for testing purposes as shown in Figure 19.4.

Data Visualisation
if ( /^FT
source
/ )
{
( $Image_Size_X ) = m/(\d*)$/;
print "D: Image_Size = '$Image_Size_X'\n";
}
if ( /^FT
CDS/ )
{
( $start, $end ) = m/(\d*)\.\.(\d*)/;
}
if ( /\/gene=/ )
{
( my $gene ) = m/\"(\w*)\"/;
print "D: Gene
= '$gene'\n";
push @Features, [ $start, $end, $gene ];
}
}
my $image = new GD::Image( $Image_Size_X, $Image_Size_Y );
my $White = $image->colorAllocate( 255, 255, 255 );
my $Black = $image->colorAllocate(
0,
0,
0 );
my $Half
= $image->colorAllocate( 128, 128, 128 );
$image->filledRectangle( 0, $Image_Size_Y/2 - $line_width,
$end,
$Image_Size_Y/2 + $line_width,
$Black );
foreach my $C_Feature ( 0 .. $#Features )
{
my $start = $Features[ $C_Feature ][ 0 ];
my $end
= $Features[ $C_Feature ][ 1 ];
my $name
= $Features[ $C_Feature ][ 2 ];
printf( "Feature# %1i %5s
(%5i to %5i)\n",
$C_Feature, $name, $start, $end );
$image->filledRectangle( $start, 1, $end,
$Image_Size_Y-1, $Black );
$image->filledRectangle( $start + $line_width, 1 + $line_width,
$end - $line_width,
$Image_Size_Y-1 - $line_width, $Half );
$image->stringTTF( $Black, "/windows/C/WINDOWS/Fonts/albr85w.ttf",
60, 0, $start + 2 * $line_width,
$Image_Size_Y /2, $name );
}
open OUTPUT_FILE, ">Embl_sequence_graphic.png"
or die "Cannot open output file; $!.\n";
print OUTPUT_FILE $image->png;
close OUTPUT_FILE;
which, when executed, produces the image shown in Figure 19.6 on page 429. The
representing one nucleotide base.