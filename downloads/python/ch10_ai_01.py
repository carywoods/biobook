#!/usr/bin/env python3
"""
Chapter 10, Script 1 -- AI Version
Metagenomics + AI explains the gut microbiome.
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

composition = {
    "Bacteroides": 25, "Faecalibacterium": 15, "Bifidobacterium": 12,
    "Lactobacillus": 8, "Roseburia": 7, "Eubacterium": 6,
    "Clostridium": 5, "Prevotella": 4, "Ruminococcus": 3,
    "Akkermansia": 2, "Escherichia": 1
}
shannon = 2.85

print("Gut microbiome composition:")
for taxon, pct in sorted(composition.items(), key=lambda x: -x[1]):
    print(f"  {taxon}: {pct}%")
print(f"Shannon diversity: {shannon}")

print("\n--- AI: What does this microbiome profile mean? ---\n")
result = ask_ai(
    f"This is a gut microbiome profile:\n" +
    "\n".join(f"  {t}: {p}%" for t, p in sorted(composition.items(), key=lambda x: -x[1])) +
    f"\n  Shannon diversity: {shannon}\n\n"
    "Please explain:\n"
    "1. What is the gut microbiome and why does it matter?\n"
    "2. Are these normal proportions? What would be 'unhealthy'?\n"
    "3. What do the top 3 bacteria (Bacteroides, Faecalibacterium, Bifidobacterium) do?\n"
    "4. How do antibiotics affect the microbiome?\n"
    "5. What is the 'gut-brain axis'?\n\n"
    "Explain for a college freshman who eats a typical American diet."
)
print(result)
