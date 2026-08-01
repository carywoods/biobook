#!/usr/bin/env python3
"""
Chapter 5, Script 1 -- AI Version
Mutation simulation + AI explains mutation consequences.
"""

import os
import random

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

def mutate_dna(dna, rate=0.1):
    bases = ["A", "T", "G", "C"]
    return "".join(random.choice([b for b in bases if b != c]) if random.random() < rate else c for c in dna)

random.seed(42)
original = "ATGGTGCATCTGACTCCTGAGGAGAAGTCTGCCGTTACTGCCCTGTGGGGCAAGGTGAAC"
mutated = mutate_dna(original, 0.05)
changes = sum(1 for a, b in zip(original, mutated) if a != b)

print(f"Original: {original}")
print(f"Mutated:  {mutated}")
print(f"Changes:  {changes}/{len(original)} positions")

print("\n--- AI: What do these mutations mean? ---\n")
mutations = [(i+1, original[i], mutated[i]) for i in range(len(original)) if original[i] != mutated[i]]
mut_text = ", ".join(f"pos {p}: {a}->{b}" for p, a, b in mutations)

result = ask_ai(
    f"A DNA sequence was mutated at {changes} positions:\n{mut_text}\n\n"
    f"Original: {original}\nMutated:  {mutated}\n\n"
    "Please explain:\n"
    "1. Classify each mutation: transition (purine->purine or pyrimidine->pyrimidine) "
    "vs transversion (purine->pyrimidine or vice versa)\n"
    "2. At a 5% mutation rate, is this typical of real evolution?\n"
    "3. How do scientists use mutation rates to estimate evolutionary time?\n\n"
    "Keep it accessible for a college freshman."
)
print(result)
