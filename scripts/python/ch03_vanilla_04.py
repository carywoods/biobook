#!/usr/bin/env python3
"""
Chapter 3, Script 4 -- Vanilla Version
Read FASTA file and translate to protein.

Translated from: example8-2.pl and example8-3.pl
Concept: FASTA parsing, file I/O, translation pipeline
"""

import os
import tempfile

CODON_TABLE = {
    "TTT": "F", "TTC": "F", "TTA": "L", "TTG": "L", "CTT": "L", "CTC": "L", "CTA": "L", "CTG": "L",
    "ATT": "I", "ATC": "I", "ATA": "I", "ATG": "M", "GTT": "V", "GTC": "V", "GTA": "V", "GTG": "V",
    "TCT": "S", "TCC": "S", "TCA": "S", "TCG": "S", "CCT": "P", "CCC": "P", "CCA": "P", "CCG": "P",
    "ACT": "T", "ACC": "T", "ACA": "T", "ACG": "T", "GCT": "A", "GCC": "A", "GCA": "A", "GCG": "A",
    "TAT": "Y", "TAC": "Y", "TAA": "*", "TAG": "*", "CAT": "H", "CAC": "H", "CAA": "Q", "CAG": "Q",
    "AAT": "N", "AAC": "N", "AAA": "K", "AAG": "K", "GAT": "D", "GAC": "D", "GAA": "E", "GAG": "E",
    "TGT": "C", "TGC": "C", "TGA": "*", "TGG": "W", "CGT": "R", "CGC": "R", "CGA": "R", "CGG": "R",
    "AGT": "S", "AGC": "S", "AGA": "R", "AGG": "R", "GGT": "G", "GGC": "G", "GGA": "G", "GGG": "G",
}


def read_fasta(filename: str) -> dict:
    """Read a FASTA file and return {header: sequence}."""
    sequences = {}
    current_header = None
    current_seq = []
    with open(filename) as f:
        for line in f:
            line = line.strip()
            if line.startswith(">"):
                if current_header:
                    sequences[current_header] = "".join(current_seq)
                current_header = line[1:]
                current_seq = []
            else:
                current_seq.append(line)
    if current_header:
        sequences[current_header] = "".join(current_seq)
    return sequences


def translate(dna: str) -> str:
    """Translate DNA to protein."""
    protein = ""
    for i in range(0, len(dna) - 2, 3):
        protein += CODON_TABLE.get(dna[i:i+3], "?")
    return protein


def print_sequence(seq: str, width: int = 60) -> None:
    """Print a sequence with line numbers."""
    for i in range(0, len(seq), width):
        chunk = seq[i:i+width]
        print(f"  {i+1:4d} {chunk}")


# --- Main program ---
# Create a sample FASTA file
sample = """>human_hemoglobin_beta partial mRNA
ATGGTGCATCTGACTCCTGAGGAGAAGTCTGCCGTTACTGCCCTGTGGGGCAAGGTGAAC
GTGGATGAAGTTGGTGGTGAGGCCCTGGGCAGGCTGCTGGTGGTCTACCCTTGGACCCAG
AGGTTCTTTGAGTCCTTTGGGGATCTGTCCACTCCTGATGCTGTTATGGGCAACCCTAAG
GTGAAGGCTCATGGCAAGAAAGTGCTCGGTGCCTTTAGTGATGGCCTGGCTCACCTGGAC
AACCTCAAGGGCACCTTTGCCACACTGAGTGAGCTGCACTGTGACAAGCTGCACGTGGAT
CCTGAGAACTTCAGG
>mouse_hemoglobin_beta partial mRNA
ATGGTGCACCTGACTGATGCTGAGAAGGCTGCCGTTACTGCCCTGTGGGGCAAGGTGAA
CGTGGATGAAGTTGGTGGTGAGGCCCTGGGCAGG
"""

sample_file = os.path.join(tempfile.gettempdir(), "sample.dna")
with open(sample_file, "w") as f:
    f.write(sample)

# Parse the FASTA file
sequences = read_fasta(sample_file)
os.remove(sample_file)

print(f"Read {len(sequences)} sequences from FASTA file:\n")

for header, dna in sequences.items():
    print(f">{header}")
    print(f"  Length: {len(dna)} bases")
    protein = translate(dna)
    print(f"  Protein ({len(protein)} aa):")
    print_sequence(protein)
    print()
