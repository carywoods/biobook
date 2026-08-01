#!/usr/bin/env python3
"""
Chapter 6, Script 3 -- Vanilla Version
Debugging exercise: find and fix the bugs.

Translated from: example6-4.pl
Concept: debugging, common errors, reading error messages
"""

# EXERCISE: This code has 3 bugs. Find and fix them.
# Run it first to see the errors, then fix each one.

# Bug 1: Wrong variable name
dna = "CGACGTCTTCTAAGGCGA"
print(f"DNA: {dna}")

# Bug 2: Off-by-one error in loop
print("\nBases at even positions:")
for i in range(0, len(dna), 2):
    print(f"  Position {i}: {dna[i]}")

# Bug 3: Wrong comparison operator
complement = {"A": "T", "T": "A", "G": "C", "C": "G"}
comp_dna = ""
for base in dna:
    if base in complement:
        comp_dna += complement[base]
    else:
        comp_dna += "N"

print(f"\nComplement: {comp_dna}")
print(f"Reverse complement: {comp_dna[::-1]}")

# SOLUTION (uncomment to verify):
# The bugs are:
# 1. If you used 'DNA' instead of 'dna', Python is case-sensitive
# 2. range(0, len(dna), 2) skips odd positions -- try range(len(dna))
# 3. Using '=' instead of '==' in comparisons (though this example uses 'in')
