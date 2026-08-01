#!/usr/bin/env python3
"""
Chapter 2, Script 4 -- Vanilla Version
Lists and iteration: working with arrays of sequences.

Translated from: example5-5.pl (Beginning Perl for Bioinformatics)
Concept: lists, for loops, enumerate, zip
"""

# A collection of short DNA sequences
sequences = [
    "ATGGCC",
    "GCTAGT",
    "TTACGA",
    "CCGATG",
    "AATTCC",
]

# Basic iteration
print("All sequences:")
for seq in sequences:
    print(f"  {seq}")

# With enumerate (numbered)
print("\nNumbered sequences:")
for i, seq in enumerate(sequences, start=1):
    print(f"  {i}. {seq} ({len(seq)} bases)")

# Lengths as a list
lengths = [len(s) for s in sequences]
print(f"\nLengths: {lengths}")
print(f"Total bases: {sum(lengths)}")
print(f"Average length: {sum(lengths) / len(lengths):.1f}")

# Filter: which sequences start with ATG?
print("\nSequences starting with ATG (potential start codons):")
starts_with_atg = [s for s in sequences if s.startswith("ATG")]
for seq in starts_with_atg:
    print(f"  {seq}")

# Parallel iteration with zip
labels = ["hemoglobin", "insulin", "p53", "BRCA1", "GAPDH"]
print("\nGene names and sequences:")
for label, seq in zip(labels, sequences):
    print(f"  {label}: {seq}")
