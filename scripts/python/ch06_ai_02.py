#!/usr/bin/env python3
"""
Chapter 6, Script 2 -- AI Version
CLI tool + AI validates and interprets the sequence.
"""

import os
import sys

try:
    from openai import OpenAI
    client = OpenAI(api_key=os.environ.get("OPENAI_API_KEY", ""), base_url=os.environ.get("OPENAI_BASE_URL", "https://openrouter.ai/api/v1"))
    AI_AVAILABLE = True
except ImportError:
    AI_AVAILABLE = False

def ask_ai(prompt: str) -> str:
    if not AI_AVAILABLE:
        return "(AI not available)"
    return client.chat.completions.create(model=os.environ.get("OPENAI_MODEL", "google/gemini-2.5-flash"), messages=[{"role": "user", "content": prompt}], temperature=0.3).choices[0].message.content

def main():
    if len(sys.argv) < 2:
        # Demo mode if no arguments
        dna = "ATGGTGCATCTGACTCCTGAGGAGAAGTCTGCCGTTACTGCCCTGTGGGGCAAGGTGAAC"
        print("(No argument provided -- running with demo sequence)\n")
    else:
        dna = sys.argv[1].upper()
    invalid = [b for b in dna if b not in "ATCG"]
    if invalid:
        print(f"Error: invalid bases: {set(invalid)}")
        sys.exit(1)

    counts = {b: dna.count(b) for b in "ATCG"}
    gc = (counts["G"] + counts["C"]) / len(dna) * 100

    print(f"DNA: {dna}")
    print(f"Length: {len(dna)}, GC: {gc:.1f}%")

    print("\n--- AI: Sequence validation ---\n")
    result = ask_ai(
        f"Validate this DNA sequence: {dna}\n"
        f"Length: {len(dna)} bp, GC content: {gc:.1f}%\n\n"
        "1. Is this GC content typical of any organism?\n"
        "2. Does it contain any known motifs (start codon, restriction sites)?\n"
        "3. Could this be a coding sequence? Why or why not?\n"
        "4. Suggest 2 experiments to characterize this sequence.\n\n"
        "Be brief and specific."
    )
    print(result)

if __name__ == "__main__":
    main()
