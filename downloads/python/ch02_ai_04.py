#!/usr/bin/env python3
"""
Chapter 2, Script 4 -- AI Version
Lists of sequences, then AI helps organize and name them.
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

sequences = ["ATGGCC", "GCTAGT", "TTACGA", "CCGATG", "AATTCC"]

print("Our sequences:")
for i, seq in enumerate(sequences, 1):
    print(f"  {i}. {seq}")

print("\n--- AI: What are these sequences? ---\n")
result = ask_ai(
    f"I have {len(sequences)} short DNA sequences:\n" +
    "\n".join(f"  {i+1}. {s}" for i, s in enumerate(sequences)) +
    "\n\nFor each sequence:\n"
    "1. Translate it to protein (use the standard genetic code)\n"
    "2. Classify it: does it start with ATG? Does it contain a stop codon?\n"
    "3. If this were part of a real gene, what might it encode?\n\n"
    "Present as a table. Be brief."
)
print(result)
