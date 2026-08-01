use strict;
my $CIFTr_path
= "~/ciftr-v2.0-linux";
my $PDB_Path
= "~/structures/pdb-select/pdbs";
my $mmCIF_Path
= "~/structures/pdb-select/structures";
$ENV{ RCSBROOT }
= $CIFTr_path;
opendir( INPUT_DIR, "$mmCIF_Path" )
or die "Error: Cannot read from mmCIF directory: '$mmCIF_Path'\n";
my @mmCIFdir = readdir( INPUT_DIR );
close INPUT_DIR;
open( OUTPUT_DIR, $PDB_Path )
or die "Error: Cannot read from PDB directory: '$PDB_Path'\n";
foreach my $Current_mmCIF_file ( @mmCIFdir )
{
if ( !( $Current_mmCIF_file =~ m/cif/i ) )
{
next;
}
my $PDB_ID
= ( $Current_mmCIF_file ) =~ m/(\d\w\w\w).cif/;
my $PDB_name
= $PDB_ID . ".pdb";
print "Now Processing '$Current_mmCIF_file' ";
print "into pdb file: '$PDB_name'\n";
my @CP_return =
'cp $mmCIF_Path/$Current_mmCIF_file .';
my @Ciftr_run =
'$CIFTr_path/bin/CIFTr -uncompress gzip -i ./$Current_mmCIF_file';
chomp( @Ciftr_run );
print join ",", @Ciftr_run,"\n";
if ( -e "./$PDB_ID.cif.pdb" )
{
my @Move_Result = 'mv $PDB_ID.cif.pdb $PDB_Path/$PDB_name';
}
else
{
die "ERROR: PDB file '$PDB_Path/$PDB_name' was not created!\n";
}
system "rm cif2pdb.err";
system "rm /tmp/file* > /dev/null";
}

The Protein Databank
The result of executing this program is a list of converted PDBs in the specified
directory. It is left as an extended exercise for the reader to work through this
program and determine how it works19. Note that the backticks surrounding the
cp, CIFTr and mv invocations cause perl to execute the specified command at
in operation to Perl's system subroutine, which is also used here.
Where to from Here
This chapter introduced the Protein Databank, commonly referred to as the PDB.
Both the legacy PDB data format and the modern replacement data format, mmCIF,
were described, and a number of programs - some custom, bespoke and others
available for download as utilities - were used to learn about the PDB and the
data it holds. In the chapters that follow, the theme of Bioinformatics data and
its usage is continued.
The Maxims Repeated
Here's a list of the maxims introduced in this chapter.
# Beware of anything in the PDB Header Section.
# It is often easier and desirable to regenerate database annotation than trawl
through entries reconstituting the annotation using custom code.
programmer's source code is a skill worth developing.

Non-redundant
Datasets
The importance of non-redundant data.
11.1
Introducing Non-redundant Datasets
This chapter discusses the need for, the problems associated with and the
practical aspects of using non-redundant datasets. The focus of this chapter is
on the PDB, as this is where the redundancy problems are most acute, because
The fundamental concepts described here apply in a wider context.
Reasons for redundancy
There may be many reasons for redundancy in a dataset. With specific reference
to the PDB, these include the following:
1. Scientific - It is often advantageous to study molecules with similar struc-
tures. This is a classic scientific investigative methodology: change a small
part, then identify the change in structure or function to form hypotheses
about the reasons for the change. Consequently, researchers are encouraged
to study similar molecules to those studied previously.
2. Technological limitations - In X-Ray Crystallography, it is easier to obtain
the structure of a molecule that is similar to one that is already known, as
Bioinformatics, Biocomputing and Perl: An Introduction to Bioinformatics
Computing Skills and Practice.
Michael Moorhouse and Paul Barry. Copyright  2004 John Wiley & Sons, Ltd. ISBN 0-470-85331-X

Non-redundant Datasets
molecules with similar conformations are likely to have similar crystallisa-
tion conditions. This, conveniently, allows two of the most difficult aspects
of using X-Ray Crystallography to be dealt with.
Reduction of redundancy
There are two reasons for supporting the reduction of a database:
1. Conceptually, to remove bias within the database. The statistical analysis
based upon the non-redundant dataset will be more representative of all the
items in the database, rather than just the largest dominant group. In the
PDB, the classic example of this activity is the removal of the many (several
hundred) similar Lysozyme structures.
2. As a practical measure, to reduce the computational requirements caused
by analysing examples that are unnecessary. For example, the PDB-Select
structural non-redundant dataset (described below) contains approximately
1600 protein structures, whereas the entire PDB contained approximately
18,000. This ten-fold reduction in size is particularly welcome should an
''all-against-all'' dataset comparison be undertaken. For 1600 items, there
are 1.27926 (calculated as comparisons 1,6001,599/2), whereas for 18,000
examples, there are 161.9916 (calculated as 18,00017,999/2). The full com-
parison takes approximately 126 times longer than the reduced redundancy
set.
Non-redundancy and non-representative
only the parent dataset from which it was produced. Information absent from
the removal of other repeated items. Although this may seem obvious, it is an
important point that is easy to forget.
Maxim 11.1 A non-redundant dataset is a subset of its parent dataset.
It is unwise to claim that the conclusions drawn from a non-redundant PDB
dataset is directly applicable to all proteins. Consider the case of membrane-
associated proteins: these exist in close proximity to a lipid environment (inside it
for some sections), which is radically different to the aqueous solution conditions
of most proteins in the PDB. Membrane-bound proteins form less than 1% (about
10 structures) by proportion of the PDB, compared to the 1530% expected
from genomic prediction studies of trans-membrane helices. However, let's be
optimistic. Despite what may be missing from a non-redundant version of the
