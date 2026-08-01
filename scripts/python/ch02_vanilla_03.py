#!/usr/bin/env python3
"""
Chapter 2, Script 3 -- Vanilla Version
Conditionals: identifying start and stop codons.

Translated from: example5-1.pl (Beginning Perl for Bioinformatics)
Concept: if/elif/else, string comparison, biological logic
"""

codon = "ATG"

# Check if this is a start codon
if codon == "ATG":
    print(f"{codon} is the universal start codon (codes for Methionine)")
elif codon in ("TAA", "TAG", "TGA"):
    print(f"{codon} is a stop codon (translation ends here)")
else:
    print(f"{codon} is a regular codon")

# Check a sequence for start and stop codons
dna = "ATGGCCTGAACCGATCGATCG"
print(f"\nAnalyzing: {dna}")
print(f"First 3 bases: {dna[:3]}")
print(f"Last 3 bases:  {dna[-3:]}")

if dna[:3] == "ATG":
    print("  -> Starts with ATG (start codon)")
else:
    print(f"  -> Starts with {dna[:3]} (not a start codon)")

if dna[-3:] in ("TAA", "TAG", "TGA"):
    print(f"  -> Ends with {dna[-3:]} (stop codon)")
else:
    print(f"  -> Ends with {dna[-3:]} (not a stop codon)")

# Categorize multiple codons
print("\nCodon classification:")
codons = ["ATG", "TAA", "GCT", "TGA", "TAG", "ATC", "TTT"]
for c in codons:
    if c == "ATG":
        category = "START"
    elif c in ("TAA", "TAG", "TGA"):
        category = "STOP"
    else:
        category = "coding"
    print(f"  {c}: {category}")
