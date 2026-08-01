#!/usr/bin/env python3
"""
Chapter 6, Script 2 -- Vanilla Version
Command-line arguments and error handling.

Translated from: example6-3.pl
Concept: sys.argv, argparse, error handling, user input
"""

import sys


def count_bases(dna: str) -> dict:
    """Count each base in a DNA sequence."""
    counts = {}
    for base in dna.upper():
        if base in "ATCG":
            counts[base] = counts.get(base, 0) + 1
    return counts


def main():
    # Check command-line arguments
    if len(sys.argv) < 2:
        # Demo mode if no arguments
        dna = "ATGGTGCATCTGACTCCTGAGGAGAAGTCTGCCGTTACTGCCCTGTGGGGCAAGGTGAAC"
        print("(No argument provided -- running with demo sequence)\n")
    else:
        dna = sys.argv[1].upper()

    # Validate
    invalid = [b for b in dna if b not in "ATCG"]
    if invalid:
        print(f"Error: invalid bases found: {set(invalid)}")
        print("DNA sequences should only contain A, T, C, G")
        sys.exit(1)

    print(f"DNA: {dna}")
    print(f"Length: {len(dna)} bases")

    counts = count_bases(dna)
    print("\nBase counts:")
    for base in sorted(counts):
        pct = counts[base] / len(dna) * 100
        print(f"  {base}: {counts[base]} ({pct:.1f}%)")

    gc = (counts.get("G", 0) + counts.get("C", 0)) / len(dna) * 100
    print(f"\nGC content: {gc:.1f}%")


if __name__ == "__main__":
    main()
