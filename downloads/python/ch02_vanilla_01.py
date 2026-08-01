#!/usr/bin/env python3
"""
Chapter 2, Script 1 -- Vanilla Version
Store and print a DNA sequence.

Translated from: example4-1.pl (Beginning Perl for Bioinformatics)
Concept: variables, strings, print()
"""

# Store a DNA sequence in a variable
dna = "ACGGGAGGACGGGAAAATTACTACGGCATTAGC"

# Print it
print(dna)

# A few things you can do with a string
print(f"Length: {len(dna)}")
print(f"First base: {dna[0]}")
print(f"Last base: {dna[-1]}")
print(f"First 10 bases: {dna[:10]}")
