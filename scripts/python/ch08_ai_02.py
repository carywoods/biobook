#!/usr/bin/env python3
"""
Chapter 8, Script 2 -- AI Version
AlphaFold + AI explains structure prediction and confidence.
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

# Simulated AlphaFold results for hemoglobin beta
print("AlphaFold prediction: Human Hemoglobin Beta (P68871)")
print(f"  Length: 147 amino acids")
print(f"  Average pLDDT: 92.4 (very high confidence)")
print(f"  High confidence residues: 130/147 (88%)")
print(f"  Low confidence residues: 5/147 (3%)")

print("\n--- AI: How does AlphaFold work? ---\n")
result = ask_ai(
    "AlphaFold predicted the structure of hemoglobin beta with 92.4 average pLDDT.\n\n"
    "Please explain:\n"
    "1. What is AlphaFold and why was it a breakthrough?\n"
    "2. What does pLDDT mean? How should I interpret scores of 90+, 70-90, and <70?\n"
    "3. How is AlphaFold different from X-ray crystallography and cryo-EM?\n"
    "4. What are AlphaFold's limitations? When might it be wrong?\n"
    "5. How has AlphaFold changed drug discovery?\n\n"
    "Explain for a college student who has never heard of protein folding."
)
print(result)
