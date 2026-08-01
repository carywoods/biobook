#!/usr/bin/env python3
"""
Chapter 3, Script 3 -- Vanilla Version
Functions: append nucleotides and substitute bases.

Translated from: example6-1.pl and example6-2.pl
Concept: functions, return values, str.replace()
"""


def append_bases(dna: str, bases: str) -> str:
    """Append nucleotides to a DNA sequence."""
    return dna + bases


def substitute_base(dna: str, old: str, new: str) -> str:
    """Replace all occurrences of a base in DNA."""
    return dna.replace(old, new)


def complement(base: str) -> str:
    """Return the complement of a single base."""
    comp = {"A": "T", "T": "A", "G": "C", "C": "G"}
    return comp.get(base, "N")


# --- Main program ---
dna = "CGACGTCTTCTCAGGCGA"
print(f"Original DNA: {dna}")

# Append
longer = append_bases(dna, "ACGT")
print(f"After appending ACGT: {longer}")

# Substitute
changed = substitute_base(dna, "A", "T")
print(f"After replacing A with T: {changed}")

# Complement each base
comp = "".join(complement(b) for b in dna)
print(f"Complement: {comp}")

# Count specific bases
for base in "ACGT":
    count = dna.count(base)
    print(f"  {base} appears {count} times")
