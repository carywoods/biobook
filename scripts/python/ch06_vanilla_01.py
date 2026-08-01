#!/usr/bin/env python3
"""
Chapter 6, Script 1 -- Vanilla Version
Restriction enzyme mapping.

Translated from: example9-2.pl and example9-3.pl
Concept: restriction enzymes, regex on DNA, enzyme databases
"""

import re

# Common restriction enzymes and their recognition sites
ENZYMES = {
    "EcoRI": "GAATTC",
    "BamHI": "GGATCC",
    "HindIII": "AAGCTT",
    "XhoI": "CTCGAG",
    "NotI": "GCGGCCGC",
    "SmaI": "CCCGGG",
    "PstI": "CTGCAG",
    "KpnI": "GGTACC",
}


def find_restriction_sites(dna: str, enzymes: dict) -> dict:
    """Find all restriction enzyme cut sites in a DNA sequence."""
    results = {}
    for name, site in enzymes.items():
        positions = [m.start() for m in re.finditer(site, dna, re.IGNORECASE)]
        if positions:
            results[name] = positions
    return results


def print_restriction_map(dna: str, sites: dict) -> None:
    """Print a text-based restriction map."""
    print(f"Restriction map for {len(dna)} bp sequence:")
    print("=" * 60)

    for enzyme, positions in sorted(sites.items(), key=lambda x: x[1][0] if x[1] else 999):
        site = ENZYMES[enzyme]
        for pos in positions:
            print(f"  {enzyme:8s} ({site}) at position {pos + 1}")
            # Show context
            context_start = max(0, pos - 5)
            context_end = min(len(dna), pos + len(site) + 5)
            context = dna[context_start:context_end]
            marker = " " * (pos - context_start) + "^" * len(site)
            print(f"           ...{context}...")
            print(f"            {marker}")


# --- Main program ---
# A sample plasmid sequence (pUC19 MCS region with inserts)
dna = (
    "GAATTCGAGCTCGGTACCCGGGGATCCTCTAGAGTCGACCTGCAGGCATGCAAGCTT"
    "GGCGTAATCATGGTCATAGCTGTTTCCTGTGTGAAATTGTTATCCGCTCACAATTCCA"
    "CACAACATACGAGCCGGAAGCATAAAGTGTAAAGCCTGGGGTGCCTAATGAGTGAGCT"
    "AACTCACATTAATTGCGTTGCGCTCACTGCCCGCTTTCCAGTCGGGAAACCTGTCGTG"
    "CCAGCTGCATTAATGAATCGGCCAACGCGCGGGGAGAGGCGGTTTGCGTATTGGGCGC"
    "GAATTCCCT"
)

print(f"DNA sequence: {len(dna)} bp\n")
print(f"Sequence: {dna[:60]}...\n")

# Find all restriction sites
sites = find_restriction_sites(dna, ENZYMES)

# Print the map
print_restriction_map(dna, sites)

# Summary
print(f"\nSummary:")
print(f"  Total enzymes tested: {len(ENZYMES)}")
print(f"  Enzymes with sites: {len(sites)}")
print(f"  Total cut sites: {sum(len(p) for p in sites.values())}")

# Which enzymes cut once? (useful for cloning)
print(f"\nSingle cutters (useful for cloning):")
for enzyme, positions in sites.items():
    if len(positions) == 1:
        print(f"  {enzyme}: position {positions[0] + 1}")
