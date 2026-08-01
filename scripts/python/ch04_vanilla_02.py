#!/usr/bin/env python3
"""
Chapter 4, Script 2 -- Vanilla Version
Extract annotation vs sequence from GenBank records.

Translated from: example10-2.pl
Concept: GenBank structure, SeqIO record attributes, feature extraction
"""

import os
import tempfile
from Bio import SeqIO

SAMPLE_GENBANK = """\
LOCUS       HBB_GENE                576 bp    DNA     linear   PRI 01-JAN-2026
DEFINITION  Homo sapiens hemoglobin subunit beta (HBB) partial sequence.
ACCESSION   SAMPLE001
SOURCE      Homo sapiens
  ORGANISM  Homo sapiens
            Eukaryota; Metazoa; Chordata; Craniata; Vertebrata; Euteleostomi;
            Mammalia; Eutheria; Primates; Haplorrhini; Hominidae; Homo.
FEATURES             Location/Qualifiers
     source          1..576
                     /organism="Homo sapiens"
                     /mol_type="genomic DNA"
     gene            1..576
                     /gene="HBB"
     CDS             1..576
                     /gene="HBB"
                     /product="hemoglobin subunit beta"
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

sample_file = os.path.join(tempfile.gettempdir(), "hbb.gb")
with open(sample_file, "w") as f:
    f.write(SAMPLE_GENBANK)

record = SeqIO.read(sample_file, "genbank")
os.remove(sample_file)

# Show the full annotation
print("=== ANNOTATION ===")
print(f"ID: {record.id}")
print(f"Description: {record.description}")
print(f"Organism: {record.annotations.get('organism', 'unknown')}")
print(f"Topology: {record.annotations.get('topology', 'unknown')}")

# Show each feature with its qualifiers
print("\n=== FEATURES ===")
for feature in record.features:
    print(f"\n  Type: {feature.type}")
    print(f"  Location: {feature.location}")
    for key, values in feature.qualifiers.items():
        for val in values:
            print(f"    {key}: {val}")

# Show the raw sequence
print(f"\n=== SEQUENCE ({len(record.seq)} bp) ===")
seq = str(record.seq)
for i in range(0, len(seq), 60):
    print(f"  {i+1:4d} {seq[i:i+60]}")
