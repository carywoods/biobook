#!/usr/bin/env python3
"""
Chapter 2, Script 3 -- AI Version
Conditionals with codons, then AI explains the genetic code logic.

Same conditionals as vanilla, but AI explains why codons are classified this way.
"""

import os

try:
    from openai import OpenAI
    client = OpenAI(api_key=os.environ.get("OPENAI_API_KEY", ""), base_url=os.environ.get("OPENAI_BASE_URL", "https://openrouter.ai/api/v1"))
    AI_AVAILABLE = True
except ImportError:
    AI_AVAILABLE = False
    print("Note: Install openai package for AI features (pip install openai)\n")

def ask_ai(prompt: str) -> str:
    if not AI_AVAILABLE:
        return "(AI not available)"
    response = client.chat.completions.create(model=os.environ.get("OPENAI_MODEL", "google/gemini-2.5-flash"), messages=[{"role": "user", "content": prompt}], temperature=0.3)
    return response.choices[0].message.content

codons = ["ATG", "TAA", "GCT", "TGA", "TAG", "ATC", "TTT"]
print("Codon classification:")
for c in codons:
    if c == "ATG":
        category = "START"
    elif c in ("TAA", "TAG", "TGA"):
        category = "STOP"
    else:
        category = "coding"
    print(f"  {c}: {category}")

print("\n--- AI: Why does the genetic code work this way? ---\n")
result = ask_ai(
    "I classified DNA codons into START (ATG), STOP (TAA, TAG, TGA), and coding.\n\n"
    "Please explain:\n"
    "1. Why is ATG the universal start codon? Is it always the first codon?\n"
    "2. Why are there exactly three stop codons and not one?\n"
    "3. There are 64 possible codons (4^3) but only 20 amino acids. "
    "What does this 'redundancy' mean? Is it a bug or a feature?\n\n"
    "Use analogies a non-scientist would understand."
)
print(result)
