#!/usr/bin/env python3
"""
Chapter 3, Script 3 -- AI Version
DNA operations + AI explains mutations and their consequences.
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
        return "(AI not available)"
    return client.chat.completions.create(model=os.environ.get("OPENAI_MODEL", "google/gemini-2.5-flash"), messages=[{"role": "user", "content": prompt}], temperature=0.3).choices[0].message.content

dna = "CGACGTCTTCTCAGGCGA"
print(f"Original: {dna}")

changed = dna.replace("A", "T")
print(f"A->T:     {changed}")

print("\n--- AI: What happens when we mutate DNA? ---\n")
result = ask_ai(
    f"I replaced every A with T in a DNA sequence:\n"
    f"Original: {dna}\n"
    f"Mutated:  {changed}\n\n"
    "Explain:\n"
    "1. This is a substitution mutation. What types of point mutations exist?\n"
    "2. If this sequence were part of a gene, what could happen to the protein?\n"
    "3. What is the difference between a synonymous and non-synonymous mutation?\n\n"
    "Use an analogy: think of DNA as a recipe book."
)
print(result)
