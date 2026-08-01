#!/usr/bin/env python3
"""
Chapter 3, Script 1 -- AI Version
Translate DNA to protein, then use AI to explain the biology.

Same translation logic as vanilla, but AI explains what each amino acid means.
Concept: the genetic code, codon tables, AI-assisted biological interpretation
"""

import os

try:
    from openai import OpenAI
    client = OpenAI(
        api_key=os.environ.get("OPENAI_API_KEY", ""),
        base_url=os.environ.get("OPENAI_BASE_URL", "https://openrouter.ai/api/v1"),
    )
    AI_AVAILABLE = True
except ImportError:
    AI_AVAILABLE = False
    print("Note: Install openai package for AI features (pip install openai)\n")


def ask_ai(prompt: str) -> str:
    if not AI_AVAILABLE:
        return "(AI not available -- set OPENAI_API_KEY environment variable)"
    response = client.chat.completions.create(
        model=os.environ.get("OPENAI_MODEL", "google/gemini-2.5-flash"),
        messages=[{"role": "user", "content": prompt}],
        temperature=0.3,
    )
    return response.choices[0].message.content


# Same genetic code and translation as vanilla
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
    protein = ""
    for i in range(0, len(dna) - 2, 3):
        codon = dna[i:i + 3]
        amino_acid = CODON_TABLE.get(codon, "?")
        protein += amino_acid
    return protein


# --- Main program ---
dna = "CGACGTCTTCGTACGGGACTAGCTCGTGTCGGTCGC"
protein = translate(dna)

print(f"DNA:     {dna}")
print(f"Protein: {protein}")
print(f"Length:  {len(protein)} amino acids")

# --- AI: Explain the protein ---
print("\n--- AI: What does this protein sequence mean? ---\n")

result = ask_ai(
    f"I translated a DNA sequence into a protein.\n\n"
    f"DNA: {dna}\n"
    f"Protein: {protein}\n\n"
    "Please explain:\n"
    "1. What do the one-letter amino acid codes mean? "
    "(List each unique amino acid in this protein with its full name)\n"
    "2. Is this protein likely to be functional? Why or why not?\n"
    "3. What kind of protein might contain this sequence?\n\n"
    "Explain for a college student with no biology background."
)
print(result)

# --- AI: Explain the stop codon ---
print("\n--- AI: Why does translation stop? ---\n")

if "*" in protein:
    stop_pos = protein.index("*")
    result = ask_ai(
        f"The protein sequence {protein} has a stop codon (*) at position {stop_pos + 1}.\n"
        f"The DNA codon at that position is {dna[stop_pos*3:stop_pos*3+3]}.\n\n"
        "Explain what a stop codon is and why it matters for protein synthesis. "
        "Use an analogy that a non-scientist would understand."
    )
    print(result)
else:
    print("No stop codon found -- this might be a partial sequence.")
