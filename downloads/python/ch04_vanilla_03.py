#!/usr/bin/env python3
"""
Chapter 4, Script 3 -- Vanilla Version
Write FASTA output.

Translated from: example12-4.pl
Concept: FASTA format, file writing, Bio.SeqIO
"""

from Bio.SeqRecord import SeqRecord
from Bio.Seq import Seq

# Create sequence records
sequences = [
    SeqRecord(Seq("ATGGTGCATCTGACTCCTGAGGAGAAGTCTGCCGTTACTGCCCTGTGGGGCAAGGTGAAC"),
              id="seq001", description="hemoglobin beta fragment 1"),
    SeqRecord(Seq("GTGGATGAAGTTGGTGGTGAGGCCCTGGGCAGGCTGCTGGTGGTCTACCCTTGGACCCAG"),
              id="seq002", description="hemoglobin beta fragment 2"),
    SeqRecord(Seq("AGGTTCTTTGAGTCCTTTGGGGATCTGTCCACTCCTGATGCTGTTATGGGCAACCCTAAG"),
              id="seq003", description="hemoglobin beta fragment 3"),
]

# Write to stdout in FASTA format
from Bio import SeqIO
import sys

print("=== FASTA output ===")
SeqIO.write(sequences, sys.stdout, "fasta")

# Write to file
output_file = "/tmp/output.fasta"
count = SeqIO.write(sequences, output_file, "fasta")
print(f"\nWrote {count} sequences to {output_file}")

# Read it back to verify
print("\n=== Read back ===")
for record in SeqIO.parse(output_file, "fasta"):
    print(f"{record.id}: {record.seq[:30]}... ({len(record.seq)} bp)")

import os
os.remove(output_file)
