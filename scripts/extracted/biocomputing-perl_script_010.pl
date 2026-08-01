use strict;
use constant
CONTACT_DEFINITION => 12;
my $Chain = "*";
my $Previous_Res = '';
if ( $#ARGV == -1 )
{
die "Usage: CA_dist_calc.pl <PDB FILE> [Chain]\n";
}
elsif ( $#ARGV == 1 )
{
$Chain = pop @ARGV;
}
my %Atoms;
my @Res_List;
while ( <> )
{

The Protein Databank
if ( /^ENDMDL/ or /^TER/ )
{
last;
}
if ( !/^ATOM/ or substr( $_, 13, 3 ) ne "CA " )
{
next;
}
if ( ( substr( $_, 21, 1 ) ne $Chain ) and
( $Chain ne "*" ) )
{
next;
}
my $Res_Number = substr( $_, 22, 4 );
if ( $Res_Number eq $Previous_Res )
{
next;
}
else
{
$Previous_Res = $Res_Number;
}
$Res_Number =~ s/ //g;
push @Res_List, $Res_Number;
my ( $X, $Y, $Z ) = ( substr( $_, 30, 8 ),
substr( $_, 38, 8 ),
substr( $_, 46, 8 ) );
$X =~ s/ //g;
$Y =~ s/ //g;
$Z =~ s/ //g;
$Atoms{ $Res_Number }{ X } = $X;
$Atoms{ $Res_Number }{ Y } = $Y;
$Atoms{ $Res_Number }{ Z } = $Z;
}
print "Number of Residues: ", $#Res_List+1, "\n";
foreach my $Current_Res_Column ( @Res_List )
{
printf "%03d: ", $Current_Res_Column;
foreach my $Current_Res_Row ( @Res_List )
{
my $Dist = sqrt( ( $Atoms{ $Current_Res_Column }{ X } -
$Atoms{ $Current_Res_Row }{ X } ) ** 2 +
( $Atoms{ $Current_Res_Column }{ Y } -
$Atoms{ $Current_Res_Row }{ Y } ) ** 2 +
( $Atoms{ $Current_Res_Column }{ Z } -
$Atoms{ $Current_Res_Row }{ Z } ) ** 2 );