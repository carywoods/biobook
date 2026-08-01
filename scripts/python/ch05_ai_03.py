#!/usr/bin/env python3
"""
Chapter 5, Script 2 -- AI Version
Random sequence comparison + AI explains what similarity means biologically.
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

def random_dna(length):
    return "".join(random.choice("ATCG") for _ in range(length))

def percent_identity(s1, s2):
    return sum(1 for a, b in zip(s1, s2) if a == b) / min(len(s1), len(s2)) * 100

random.seed(42)
seqs = [random_dna(random.randint(20, 30)) for _ in range(6)]

print("Random sequences:")
for i, s in enumerate(seqs, 1):
    print(f"  {i}: {s}")

identities = []
for i in range(len(seqs)):
    for j in range(i+1, len(seqs)):
        identities.append(percent_identity(seqs[i], seqs[j]))

avg = sum(identities)/len(identities)
print(f"\nAverage pairwise identity: {avg:.1f}%")
print(f"Expected for random DNA: ~25%")

print("\n--- AI: When does sequence similarity matter? ---\n")
result = ask_ai(
    f"I compared {len(seqs)} random DNA sequences and found {avg:.1f}% average identity.\n"
    "For random sequences, we expect ~25%.\n\n"
    "Explain:\n"
    "1. If two REAL gene sequences are 90% identical, what does that mean?\n"
    "2. What's the difference between 'homology' and 'similarity'?\n"
    "3. How do scientists decide if two sequences are 'significantly similar'?\n"
    "4. What is an E-value in BLAST, and why does it matter?\n\n"
    "Use an analogy: comparing DNA is like comparing two editions of a book."
)
print(result)
