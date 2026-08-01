#!/usr/bin/env python3
"""
Chapter 5, Script 3 -- Vanilla Version
Search for motifs in protein sequences.

Translated from: example5-3.pl
Concept: regex for biology, pattern matching, motif discovery
"""

import re

def find_motifs(sequence: str, pattern: str) -> list:
    """Find all occurrences of a motif pattern in a sequence."""
    return [(m.start(), m.group()) for m in re.finditer(pattern, sequence, re.IGNORECASE)]


# --- Main program ---
# A partial human insulin protein sequence
protein = "MALWMRLLPLLALLALWGPDPAAAFVNQHLCGSHLVEALYLVCGERGFFYTPKT"

print(f"Protein sequence ({len(protein)} aa):")
print(f"  {protein}\n")

# Search for common motifs
motifs = {
    "N-glycosylation": r"N[^P][ST][^P]",  # Asn-X-Ser/Thr (X != Pro)
    "Phosphorylation (Ser)": r"[ST]..[DE]",  # Ser/Thr followed by acidic residues
    "Zinc finger (C2H2)": r"C.{2,4}C.{12}H.{3,5}H",
    "Leucine zipper": r"L.{6}L.{6}L.{6}L",
    "KR cleavage site": r"KR|RR",  # dibasic cleavage
}

print("Motif search results:")
print("-" * 50)
for name, pattern in motifs.items():
    matches = find_motifs(protein, pattern)
    if matches:
        print(f"  {name}:")
        for pos, match in matches:
            print(f"    Position {pos}: {match}")
    else:
        print(f"  {name}: not found")

# Custom pattern search
print("\nCustom pattern search:")
# Find all occurrences of a specific amino acid pattern
pattern = "LL"
matches = find_motifs(protein, pattern)
print(f"  Pattern '{pattern}' found {len(matches)} times:")
for pos, match in matches:
    print(f"    Position {pos}: ...{protein[max(0,pos-3):pos+len(match)+3]}...")
