#!/usr/bin/env python3
"""
Chapter 3, Script 2 -- AI Version
Translate in all six reading frames, then use AI to pick the best one.

Same translation logic as vanilla, but AI helps interpret which frame is real.
Concept: reading frames, reverse complement, AI-assisted ORF analysis
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
    return "".join(COMPLEMENT.get(base, "N") for base in reversed(dna))


def translate(dna: str) -> str:
    protein = ""
    for i in range(0, len(dna) - 2, 3):
        codon = dna[i:i + 3]
        protein += CODON_TABLE.get(codon, "?")
    return protein


def translate_frame(dna: str, frame: int) -> str:
    return translate(dna[frame:])


# --- Main program ---
dna = "CGACGTCTTCGTACGGGACTAGCTCGTGTCGGTCGC"
revcomp = reverse_complement(dna)

print(f"DNA: {dna}")
print(f"RevComp: {revcomp}\n")

# Collect all six frames
frames = {}
for frame in range(3):
    frames[f"+{frame + 1}"] = translate_frame(dna, frame)
for frame in range(3):
    frames[f"-{frame + 1}"] = translate_frame(revcomp, frame)

print("Six reading frame translations:")
for name, protein in frames.items():
    print(f"  Frame {name}: {protein}")

# --- AI: Which frame is most likely the real gene? ---
print("\n--- AI: Which reading frame is the real gene? ---\n")

frame_report = "\n".join(f"  Frame {name}: {protein}" for name, protein in frames.items())

result = ask_ai(
    f"I have a DNA sequence and its translations in six reading frames:\n\n"
    f"DNA: {dna}\n\n"
    f"{frame_report}\n\n"
    "Please analyze:\n"
    "1. Which frame is most likely to contain a real protein? Why?\n"
    "   (Look for: starts with M, reasonable length before a stop, "
    "no stop codons interrupting it)\n"
    "2. What is the longest open reading frame across all frames?\n"
    "3. For a non-scientist: why do biologists look at all six frames "
    "instead of just one?\n\n"
    "Be specific about which frame you recommend and why."
)
print(result)

# --- AI: Amino acid composition analysis ---
print("\n--- AI: Amino acid composition ---\n")

# Find the longest frame without stops
best_frame = max(frames.items(), key=lambda x: len(x[1].replace("*", "")))
result = ask_ai(
    f"The longest open reading frame is in frame {best_frame[0]}: {best_frame[1]}\n\n"
    "Analyze the amino acid composition:\n"
    "1. Which amino acids appear most frequently?\n"
    "2. Is this composition typical of any class of proteins?\n"
    "3. What can we infer about the chemical properties of this protein?\n\n"
    "Keep it brief and accessible."
)
print(result)
