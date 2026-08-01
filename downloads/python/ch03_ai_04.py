#!/usr/bin/env python3
"""
Chapter 3, Script 4 -- AI Version
FASTA parsing + translation, then AI compares species.
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

try:
    from openai import OpenAI
    client = OpenAI(api_key=os.environ.get("OPENAI_API_KEY", ""), base_url=os.environ.get("OPENAI_BASE_URL", "https://openrouter.ai/api/v1"))
    AI_AVAILABLE = True
except ImportError:
    AI_AVAILABLE = False
    print("Note: Install openai package for AI features\n")

def ask_ai(prompt: str) -> str:
    if not AI_AVAILABLE:
        return "(AI not available)"
    return client.chat.completions.create(model=os.environ.get("OPENAI_MODEL", "google/gemini-2.5-flash"), messages=[{"role": "user", "content": prompt}], temperature=0.3).choices[0].message.content

def read_fasta(filename: str) -> dict:
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
    protein = ""
    for i in range(0, len(dna) - 2, 3):
        protein += CODON_TABLE.get(dna[i:i+3], "?")
    return protein

# Create sample data
sample = """>human_hemoglobin_beta
ATGGTGCATCTGACTCCTGAGGAGAAGTCTGCCGTTACTGCCCTGTGGGGCAAGGTGAACGTGGATGAAGTTGGTGGTGAGGCCCTGGGCAGGCTGCTGGTGGTCTACCCTTGGACCCAGAGGTTCTTTGAGTCCTTTGGGGATCTGTCCACTCCTGATGCTGTTATGGGCAACCCTAAGGTGAAGGCTCATGGCAAGAAAGTGCTCGGTGCCTTTAGTGATGGCCTGGCTCACCTGGACAACCTCAAGGGCACCTTTGCCACACTGAGTGAGCTGCACTGTGACAAGCTGCACGTGGATCCTGAGAACTTCAGG
>mouse_hemoglobin_beta
ATGGTGCACCTGACTGATGCTGAGAAGGCTGCCGTTACTGCCCTGTGGGGCAAGGTGAACGTGGATGAAGTTGGTGGTGAGGCCCTGGGCAGG"""

sample_file = os.path.join(tempfile.gettempdir(), "sample.dna")
with open(sample_file, "w") as f:
    f.write(sample)

sequences = read_fasta(sample_file)
os.remove(sample_file)

print(f"Read {len(sequences)} sequences:\n")
proteins = {}
for header, dna in sequences.items():
    protein = translate(dna)
    proteins[header] = protein
    print(f">{header}")
    print(f"  DNA ({len(dna)} bp): {dna[:40]}...")
    print(f"  Protein ({len(protein)} aa): {protein[:40]}...")
    print()

# --- AI: Compare across species ---
print("--- AI: Comparing hemoglobin across species ---\n")
result = ask_ai(
    f"I have hemoglobin beta sequences from two species:\n\n"
    f"Human protein: {proteins.get('human_hemoglobin_beta', 'N/A')}\n"
    f"Mouse protein: {proteins.get('mouse_hemoglobin_beta', 'N/A')}\n\n"
    "Please:\n"
    "1. How similar are these two protein sequences? Count the identical positions.\n"
    "2. What does this similarity tell us about evolution?\n"
    "3. Why is hemoglobin one of the most-studied proteins in biology?\n\n"
    "Explain for a non-biology major."
)
print(result)
