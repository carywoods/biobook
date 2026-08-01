#!/usr/bin/env python3
"""
Chapter 4, Script 1 -- Vanilla Version
Parse a GenBank file and extract annotation and sequence.

Translated from: example10-1.pl (Beginning Perl for Bioinformatics)
Concept: file formats, structured data, Bio.SeqIO, GenBank records
"""

from Bio import SeqIO


def parse_genbank(filename: str) -> None:
    """Parse a GenBank file and display its contents."""
    record = SeqIO.read(filename, "genbank")

    # Basic information
    print(f"ID:          {record.id}")
    print(f"Name:        {record.name}")
    print(f"Description: {record.description}")
    print(f"Length:       {len(record.seq)} bases")
    print(f"Molecule:     {record.annotations.get('molecule_type', 'unknown')}")
    print(f"Organism:     {record.annotations.get('organism', 'unknown')}")

    # Sequence
    print(f"\nSequence (first 60 bases):")
    seq_str = str(record.seq)
    for i in range(0, min(60, len(seq_str)), 60):
        print(f"  {seq_str[i:i+60]}")

    # Features
    print(f"\nFeatures ({len(record.features)} total):")
    for feature in record.features[:10]:  # Show first 10
        print(f"  {feature.type}: {feature.location}")
        if "gene" in feature.qualifiers:
            print(f"    Gene: {feature.qualifiers['gene']}")
        if "product" in feature.qualifiers:
            print(f"    Product: {feature.qualifiers['product']}")

    if len(record.features) > 10:
        print(f"  ... and {len(record.features) - 10} more features")

    # References
    print(f"\nReferences ({len(record.annotations.get('references', []))}):")
    for ref in record.annotations.get("references", []):
        print(f"  {ref.title[:80]}..." if ref.title and len(ref.title) > 80 else f"  {ref.title}")


# --- Main program ---
# Use a sample GenBank file if available, otherwise create one
import os
import tempfile

SAMPLE_GENBANK = """\
LOCUS       SAMPLE_SEQ              576 bp    DNA     linear   PRI 01-JAN-2026
DEFINITION  Homo sapiens hemoglobin subunit beta (HBB) partial sequence.
ACCESSION   SAMPLE001
VERSION     SAMPLE001.1
KEYWORDS    .
SOURCE      Homo sapiens
  ORGANISM  Homo sapiens
            Eukaryota; Metazoa; Chordata; Craniata; Vertebrata; Euteleostomi;
            Mammalia; Eutheria; Euarchontoglires; Primates; Haplorrhini;
            Catarrhini; Hominidae; Homo.
FEATURES             Location/Qualifiers
     source          1..576
                     /organism="Homo sapiens"
                     /mol_type="genomic DNA"
     gene            1..576
                     /gene="HBB"
     CDS             1..576
                     /gene="HBB"
                     /product="hemoglobin subunit beta"
                     /translation="MVHLTPEEKSAVTALWGKVNVDEVGGEALGRLLVVYPWTQRFFES
                     FGDLSTPDAVMGNPKVKAHGKKVLGAFSDGLAHLDNLKGTFATLSELHCDKLHVDPE
                     NFRLLGNVLVCVLAHHFGKEFTPPVQAAYQKVVAGVANALAHKYH"
ORIGIN
        1 atggtgcatc tgactcctga ggagaagtct gccgttactg ccctgtgggg caaggtgaac
       61 gtggatgaag ttggtggtga ggccctgggc aggctgctgg tggtctaccc ttggacccag
      121 aggttctttg agtcctttgg ggatctgtcc actcctgatg ctgttatggg caaccctaag
      181 gtgaaggctc atggcaagaa agtgctcggt gcctttagtg atggcctggc tcacctggac
      241 aacctcaagg gcacctttgc cacactgagt gagctgcact gtgacaagct gcacgtggat
      301 cctgagaact tcagggagcc tctgccatgc tggatacatt catcacccag aatccaggac
      361 tccagccttc tgggcatcat tctgaccctc agctgcctcc aggtcctctg cttgagcttc
      421 cctttctgtt tcctgtccaa tctgctccca cccatggcta ttgagacact cttgttccct
      481 cctctgctga tgtggaagct gaaggtgctg gacttcatca cctttgccaa cctgctgggt
      541 gccctgtgga tgaactatgg caagaacttc atgacc
//
"""

# Write sample file
sample_file = os.path.join(tempfile.gettempdir(), "sample.gb")
with open(sample_file, "w") as f:
    f.write(SAMPLE_GENBANK)

print(f"Parsing sample GenBank file: {sample_file}\n")
parse_genbank(sample_file)

# Clean up
os.remove(sample_file)
