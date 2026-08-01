#!/usr/bin/env python3
"""
Chapter 5, Script 1 -- Vanilla Version
Count nucleotide frequencies and calculate percentages.

Translated from: example5-4.pl (Beginning Perl for Bioinformatics)
Concept: counting, dictionaries, percentages, biological interpretation
"""

from collections import Counter


def count_nucleotides(dna: str) -> dict:
    """Count each nucleotide in a DNA sequence."""
    counts = Counter(dna.upper())
    return dict(counts)


def nucleotide_percentages(dna: str) -> dict:
    """Calculate the percentage of each nucleotide."""
    counts = count_nucleotides(dna)
    total = len(dna)
    return {base: count / total * 100 for base, count in counts.items()}


def gc_content(dna: str) -> float:
    """Calculate GC content as a percentage."""
    dna = dna.upper()
    gc = dna.count("G") + dna.count("C")
    return gc / len(dna) * 100


# --- Main program ---
# A real human hemoglobin subunit beta mRNA fragment
dna = (
    "ATGGTGCATCTGACTCCTGAGGAGAAGTCTGCCGTTACTGCCCTGTGGGGCAAGGTG"
    "AACGTGGATGAAGTTGGTGGTGAGGCCCTGGGCAGGCTGCTGGTGGTCTACCCTTGG"
    "ACCCAGAGGTTCTTTGAGTCCTTTGGGGATCTGTCCACTCCTGATGCTGTTATGGGCA"
    "ACCCTAAGGTGAAGGCTCATGGCAAGAAAGTGCTCGGTGCCTTTAGTGATGGCCTGG"
    "CTCACCTGGACAACCTCAAGGGCACCTTTGCCACACTGAGTGAGCTGCACTGTGACAA"
    "GCTGCACGTGGATCCTGAGAACTTCAGG"
)

print(f"DNA sequence ({len(dna)} bases):")
print(f"  {dna[:60]}...\n")

# Count nucleotides
counts = count_nucleotides(dna)
print("Nucleotide counts:")
for base in sorted(counts):
    print(f"  {base}: {counts[base]}")

# Percentages
print("\nNucleotide percentages:")
pcts = nucleotide_percentages(dna)
for base in sorted(pcts):
    print(f"  {base}: {pcts[base]:.1f}%")

# GC content
gc = gc_content(dna)
print(f"\nGC content: {gc:.1f}%")
print(f"AT content: {100 - gc:.1f}%")

# Biological interpretation
print("\nInterpretation:")
if gc > 60:
    print("  High GC content -- typical of bacteria and some plant genes")
elif gc > 45:
    print("  Moderate GC content -- typical of many vertebrate genes")
else:
    print("  Low GC content -- may indicate AT-rich region or viral origin")
