#!/usr/bin/env python3
"""
Chapter 5, Script 1 -- AI Version
Count nucleotide frequencies, then use AI to interpret the biological meaning.

Same counting logic as vanilla, but AI adds biological context.
Concept: counting, dictionaries, GC content, AI-assisted interpretation
"""

import os
from collections import Counter

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


def count_nucleotides(dna: str) -> dict:
    return dict(Counter(dna.upper()))


def nucleotide_percentages(dna: str) -> dict:
    counts = count_nucleotides(dna)
    total = len(dna)
    return {base: count / total * 100 for base, count in counts.items()}


def gc_content(dna: str) -> float:
    dna = dna.upper()
    gc = dna.count("G") + dna.count("C")
    return gc / len(dna) * 100


# --- Main program ---
dna = (
    "ATGGTGCATCTGACTCCTGAGGAGAAGTCTGCCGTTACTGCCCTGTGGGGCAAGGTG"
    "AACGTGGATGAAGTTGGTGGTGAGGCCCTGGGCAGGCTGCTGGTGGTCTACCCTTGG"
    "ACCCAGAGGTTCTTTGAGTCCTTTGGGGATCTGTCCACTCCTGATGCTGTTATGGGCA"
    "ACCCTAAGGTGAAGGCTCATGGCAAGAAAGTGCTCGGTGCCTTTAGTGATGGCCTGG"
    "CTCACCTGGACAACCTCAAGGGCACCTTTGCCACACTGAGTGAGCTGCACTGTGACAA"
    "GCTGCACGTGGATCCTGAGAACTTCAGG"
)

print(f"DNA sequence ({len(dna)} bases):")
print(f"  {dna[:60]}...\n")

counts = count_nucleotides(dna)
pcts = nucleotide_percentages(dna)
gc = gc_content(dna)

print("Nucleotide counts and percentages:")
for base in sorted(counts):
    print(f"  {base}: {counts[base]} ({pcts[base]:.1f}%)")

print(f"\nGC content: {gc:.1f}%")
print(f"AT content: {100 - gc:.1f}%")

# --- AI: What does this sequence composition tell us? ---
print("\n--- AI: Sequence composition analysis ---\n")

result = ask_ai(
    f"I analyzed a DNA sequence and found these nucleotide frequencies:\n\n"
    f"A: {pcts.get('A', 0):.1f}%\n"
    f"T: {pcts.get('T', 0):.1f}%\n"
    f"G: {pcts.get('G', 0):.1f}%\n"
    f"C: {pcts.get('C', 0):.1f}%\n"
    f"GC content: {gc:.1f}%\n"
    f"Sequence length: {len(dna)} bases\n\n"
    "Please tell me:\n"
    "1. Is this GC content typical of any particular organism or gene type?\n"
    "2. The A and T percentages -- are they expected to be roughly equal? "
    "Why or why not? (Think about base pairing)\n"
    "3. What does GC content tell us about the stability of the DNA double helix?\n\n"
    "Explain for a college student with no biology background."
)
print(result)

# --- AI: Compare to known genes ---
print("\n--- AI: Is this a known gene? ---\n")

result = ask_ai(
    f"Here is a DNA sequence of {len(dna)} bases:\n{dna}\n\n"
    "Based on the sequence alone:\n"
    "1. Does this look like it could be from a human gene? Why?\n"
    "2. The sequence starts with ATG (start codon). What does that suggest?\n"
    "3. Can you identify what gene this might be from? "
    "(It's from a very well-known human gene family.)\n\n"
    "Be specific but accessible."
)
print(result)
