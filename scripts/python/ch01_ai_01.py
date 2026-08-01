#!/usr/bin/env python3
"""
Chapter 1, Script 1 -- AI Version
Your first bioinformatics program + AI explains what DNA is.

Same program as vanilla, but AI provides biological context.
"""

import os

try:
    from openai import OpenAI
    client = OpenAI(api_key=os.environ.get("OPENAI_API_KEY", ""), base_url=os.environ.get("OPENAI_BASE_URL", "https://openrouter.ai/api/v1"))
    AI_AVAILABLE = True
except ImportError:
    AI_AVAILABLE = False
    print("Note: Install openai package for AI features\n")

def ask_ai(prompt: str) -> str:
    if not AI_AVAILABLE:
        return "(AI not available -- set OPENAI_API_KEY environment variable)"
    return client.chat.completions.create(model=os.environ.get("OPENAI_MODEL", "google/gemini-2.5-flash"), messages=[{"role": "user", "content": prompt}], temperature=0.3).choices[0].message.content

# Same code as vanilla
dna = "ATGCGATCGATCGATCGATCG"
print("Hello! This is a DNA sequence:")
print(dna)
print(f"\nThis sequence has {len(dna)} bases.")
print(f"  A: {dna.count('A')}, T: {dna.count('T')}, C: {dna.count('C')}, G: {dna.count('G')}")

complement = {"A": "T", "T": "A", "C": "G", "G": "C"}
complement_dna = "".join(complement[b] for b in dna)
print(f"\nOriginal:   {dna}")
print(f"Complement: {complement_dna}")

# Now ask AI to explain
print("\n--- AI: What is DNA? ---\n")
result = ask_ai(
    "I just wrote my first bioinformatics program. It counts DNA bases.\n\n"
    "Please explain for a college freshman who has never taken biology:\n"
    "1. What is DNA? Use an analogy they'd understand.\n"
    "2. Why are there exactly four bases (A, T, C, G)?\n"
    "3. What does 'complement' mean and why does A pair with T?\n"
    "4. How long is a typical human gene? (compare to our 20-base sequence)\n"
    "5. Why should a computer science student care about DNA?\n\n"
    "Keep it fun and accessible."
)
print(result)

print("\n--- AI: What can we do with code and DNA? ---\n")
result = ask_ai(
    "I'm a college student learning bioinformatics. In 3 sentences, "
    "what are the coolest things I'll be able to do by the end of this course? "
    "Make it sound exciting but realistic."
)
print(result)
