#!/usr/bin/env python3
"""
Chapter 3, Script 1 -- Vanilla Version
Translate a DNA sequence into a protein sequence.

Translated from: example8-1.pl (Beginning Perl for Bioinformatics)
Concept: the genetic code, codon tables, translation, dictionaries
"""

# The standard genetic code -- each 3-letter DNA codon maps to one amino acid
# This is the dictionary that makes translation possible
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


def translate(dna: str) -> str:
    """Translate a DNA sequence into a protein sequence."""
    protein = ""
    # Walk through the DNA three bases at a time
    for i in range(0, len(dna) - 2, 3):
        codon = dna[i:i + 3]
        amino_acid = CODON_TABLE.get(codon, "?")  # ? for unknown codons
        protein += amino_acid
    return protein


# --- Main program ---
dna = "CGACGTCTTCGTACGGGACTAGCTCGTGTCGGTCGC"

print(f"DNA:     {dna}")
print(f"Length:  {len(dna)} bases")

protein = translate(dna)
print(f"Protein: {protein}")
print(f"Length:  {len(protein)} amino acids")

# Show each codon and its translation
print("\nCodon-by-codon translation:")
for i in range(0, len(dna) - 2, 3):
    codon = dna[i:i + 3]
    aa = CODON_TABLE.get(codon, "?")
    print(f"  {codon} -> {aa}")
