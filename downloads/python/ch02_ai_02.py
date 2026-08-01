#!/usr/bin/env python3
"""
Chapter 2, Script 2 -- AI Version
Concatenate DNA fragments, then use AI to analyze the junction.

Same concatenation logic as vanilla, but AI examines the join point.
Concept: string operations, AI-assisted analysis of sequence junctions
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


dna1 = "ACGGGAGGACGGGAAAATTACTACGGCATTAGC"
dna2 = "ATAGTGCCGTGAGAGTGATGTAGTA"

print("Fragment 1:", dna1)
print("Fragment 2:", dna2)

combined = dna1 + dna2
print(f"\nConcatenated ({len(combined)} bases): {combined}")

# --- AI: Analyze the junction ---
print("\n--- AI: What happens at the junction? ---\n")

result = ask_ai(
    f"I concatenated two DNA fragments:\n"
    f"Fragment 1 (ends with): ...{dna1[-10:]}\n"
    f"Fragment 2 (starts with): {dna2[:10]}...\n"
    f"Combined: {combined}\n\n"
    "In molecular biology, when scientists join two DNA fragments:\n"
    "1. What is this process called? (Hint: think restriction enzymes and ligase)\n"
    "2. The junction between the two fragments -- does it create a new sequence "
    "that wasn't in either original fragment?\n"
    "3. Could this new junction accidentally create a start codon (ATG) "
    "or stop codon (TAA, TAG, TGA)?\n\n"
    "Explain for a college freshman."
)
print(result)

# --- AI: GC content comparison ---
print("\n--- AI: Comparing the fragments ---\n")

gc1 = (dna1.count("G") + dna1.count("C")) / len(dna1) * 100
gc2 = (dna2.count("G") + dna2.count("C")) / len(dna2) * 100

result = ask_ai(
    f"Two DNA fragments were concatenated:\n"
    f"Fragment 1 ({len(dna1)} bases, GC={gc1:.1f}%): {dna1}\n"
    f"Fragment 2 ({len(dna2)} bases, GC={gc2:.1f}%): {dna2}\n\n"
    "The GC content differs between the fragments. What does this tell us?\n"
    "1. Could these fragments come from different organisms?\n"
    "2. What is 'GC content' and why do scientists care about it?\n"
    "3. How might different GC content affect DNA stability?\n\n"
    "Keep it brief."
)
print(result)
