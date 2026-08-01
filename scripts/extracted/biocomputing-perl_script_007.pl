use strict;
my $Base_URL = "ftp://ftp.rcsb.org/pub/pdb/data/structures/all/pdb";
my $Output_Dir = "structures";
open URL_LIST, ">pdb_select_url.lst"

Downloading Datasets
or die "Cannot write to file: 'pdb_select_url.lst'\n";
while ( <> )
{
if ( /Failed/ )
{
next;
}
s/ //g;
my ( $Structure, $Length ) = split ( ":", $_ );
my ( $ID, $Chain ) = split ( ",", $Structure );
$ID =~ tr /[A-Z]/[a-z]/;
print URL_LIST "$Base_URL/pdb$ID.ent.Z\n";
}
close URL_LIST;
if ( !-e $Output_Dir )
{
system "mkdir $Output_Dir";
}
if ( !-w $Output_Dir or !-d $Output_Dir )
{
die "ERROR: Cannot access directory: '$Output_Dir'.
Exiting\n";
}
system "sort -u pdb_select_url.lst > unique_urls.lst";
system "rm $Output_Dir/* > /dev/null";
system "wget --output-file=log --http-user=anonymous
\
--http-passwd=email\@some.where.net
\
--directory-prefix=$Output_Dir -i unique_urls.lst";
from the URL specified in the scalar variable $Base URL6. Those structures
marked as ''Failed'' are skipped, otherwise a URL is built and written to the
pdb select url.lst file. Duplicate structures are filtered out using the ''sort
-u'' operating system utility, as it is pointless downloading the same structure
than to perform the same operation in Perl.
Error-checking is performed to see if the output directory exists (otherwise it
a regular basis, then use one of the geographically close mirror sites advertised on the RCSB
homepage.