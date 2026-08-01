#!/usr/bin/env python3
"""
Chapter 1, Script 1 -- Vanilla Version
Your first bioinformatics program: Hello World with DNA.

Concept: why bioinformatics matters, what DNA is, running Python
"""

# Welcome to Bioinformatics with AI
# This is your very first program.

# DNA is written as a string of four letters: A, T, C, G
# These stand for the four nucleotide bases:
#   A = Adenine
#   T = Thymine
#   C = Cytosine
#   G = Guanine

# Let's store a piece of DNA and do something with it
dna = "ATGCGATCGATCGATCGATCG"

# Print it
print("Hello! This is a DNA sequence:")
print(dna)

# Count the bases
print(f"\nThis sequence has {len(dna)} bases.")
print(f"  A appears {dna.count('A')} times")
print(f"  T appears {dna.count('T')} times")
print(f"  C appears {dna.count('C')} times")
print(f"  G appears {dna.count('G')} times")

# A pairs with T, and C pairs with G
# This is the base pairing rule (Watson-Crick base pairing)
print("\nBase pairing rule:")
print("  A pairs with T")
print("  C pairs with G")

# The complement of a DNA strand
complement = {"A": "T", "T": "A", "C": "G", "G": "C"}
complement_dna = "".join(complement[b] for b in dna)
print(f"\nOriginal:    {dna}")
print(f"Complement:  {complement_dna}")

print("\nCongratulations! You just wrote your first bioinformatics program.")
print("Every chapter after this builds on what you just did.")
