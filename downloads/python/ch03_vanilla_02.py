#!/usr/bin/env python3
"""
Chapter 3, Script 2 -- Vanilla Version
Translate a DNA sequence in all six reading frames.

Translated from: example8-4.pl (Beginning Perl for Bioinformatics)
Concept: reading frames, reverse complement, why 6 frames matter
"""

CODON_TABLE = {
    "TTT": "F", "TTC": "F", "TTA": "L", "TTG": "L",
    "CTT": "L", "CTC": "L", "CTA": "L", "CTG": "L",
    "ATT": "I", "ATC": "I", "ATA": "I", "ATG": "M",
    "GTT": "V", "GTC": "V", "GTA": "V", "GTG": "V",
    "TCT": "S", "TCC": "S", "TCA": "S", "TCG": "S",
    "CCT": "P", "CCC": "P", "CCA": "P", "CCG": "P",
    "ACT": "T", "ACC": "T", "ACA": "T", "ACG": "T",
    "GCT": "A", "GCC": "A", "GCA": "A", "GCG": "A",
    "TAT": "Y", "TAC": "Y", "TAA": "*", "TAG": "*",
    "CAT": "H", "CAC": "H", "CAA": "Q", "CAG": "Q",
    "AAT": "N", "AAC": "N", "AAA": "K", "AAG": "K",
    "GAT": "D", "GAC": "D", "GAA": "E", "GAG": "E",
    "TGT": "C", "TGC": "C", "TGA": "*", "TGG": "W",
    "CGT": "R", "CGC": "R", "CGA": "R", "CGG": "R",
    "AGT": "S", "AGC": "S", "AGA": "R", "AGG": "R",
    "GGT": "G", "GGC": "G", "GGA": "G", "GGG": "G",
}

COMPLEMENT = {"A": "T", "T": "A", "G": "C", "C": "G"}


def reverse_complement(dna: str) -> str:
    """Return the reverse complement of a DNA sequence."""
    return "".join(COMPLEMENT.get(base, "N") for base in reversed(dna))


def translate(dna: str) -> str:
    """Translate DNA to protein."""
    protein = ""
    for i in range(0, len(dna) - 2, 3):
        codon = dna[i:i + 3]
        protein += CODON_TABLE.get(codon, "?")
    return protein


def translate_frame(dna: str, frame: int) -> str:
    """Translate starting from a specific reading frame (0, 1, or 2)."""
    return translate(dna[frame:])


# --- Main program ---
dna = "CGACGTCTTCGTACGGGACTAGCTCGTGTCGGTCGC"

print(f"DNA sequence ({len(dna)} bases):")
print(f"  {dna}\n")

# The six reading frames:
# Frames +1, +2, +3: forward strand, starting at positions 0, 1, 2
# Frames -1, -2, -3: reverse complement, starting at positions 0, 1, 2
revcomp = reverse_complement(dna)

print(f"Reverse complement:")
print(f"  {revcomp}\n")

print("Six reading frame translations:")
print("-" * 50)

for frame in range(3):
    protein = translate_frame(dna, frame)
    print(f"  Frame +{frame + 1}: {protein}")

for frame in range(3):
    protein = translate_frame(revcomp, frame)
    print(f"  Frame -{frame + 1}: {protein}")

# Look for open reading frames (start at M, stop at *)
print("\nOpen reading frames (M...*):")
for frame in range(3):
    protein = translate_frame(dna, frame)
    # Find M...* patterns
    start = 0
    while start < len(protein):
        m_pos = protein.find("M", start)
        if m_pos == -1:
            break
        stop = protein.find("*", m_pos)
        if stop == -1:
            orf = protein[m_pos:]
            print(f"  Frame +{frame + 1}: M{orf} (no stop codon)")
            break
        else:
            orf = protein[m_pos:stop + 1]
            print(f"  Frame +{frame + 1}: {orf}")
            start = stop + 1
