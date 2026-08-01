#!/usr/bin/env python3
"""
Chapter 2, Script 2 -- Vanilla Version
Concatenate DNA fragments.

Translated from: example4-2.pl (Beginning Perl for Bioinformatics)
Concept: string concatenation, variables, f-strings
"""

# Two DNA fragments
dna1 = "ACGGGAGGACGGGAAAATTACTACGGCATTAGC"
dna2 = "ATAGTGCCGTGAGAGTGATGTAGTA"

print("Here are the original two DNA fragments:\n")
print(dna1)
print(dna2)

# Concatenate them
combined = dna1 + dna2
print(f"\nConcatenated DNA ({len(combined)} bases):")
print(combined)

# You can also use f-strings
print(f"\nFragment 1 is {len(dna1)} bases, fragment 2 is {len(dna2)} bases")
print(f"Combined length: {len(dna1) + len(dna2)} bases")

# Insert a spacer
spacer = "NNNNN"
with_spacer = dna1 + spacer + dna2
print(f"\nWith spacer '{spacer}':")
print(with_spacer)
