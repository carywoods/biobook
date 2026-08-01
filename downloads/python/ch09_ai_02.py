#!/usr/bin/env python3
"""
Chapter 9, Script 2 -- AI Version
Variant annotation + AI explains clinical significance.
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

variants = [
    {"gene": "BRAF", "change": "V600E", "effect": "missense", "disease": "melanoma"},
    {"gene": "KRAS", "change": "G12D", "effect": "missense", "disease": "pancreatic cancer"},
    {"gene": "HBB", "change": "E6V", "effect": "missense", "disease": "sickle cell disease"},
]

print("Pathogenic variants:")
for v in variants:
    print(f"  {v['gene']} {v['change']}: {v['effect']} -- {v['disease']}")

print("\n--- AI: From mutation to disease mechanism ---\n")
result = ask_ai(
    f"These three mutations all change one amino acid:\n"
    f"  BRAF V600E: valine -> glutamic acid at position 600\n"
    f"  KRAS G12D: glycine -> aspartic acid at position 12\n"
    f"  HBB E6V: glutamic acid -> valine at position 6\n\n"
    "For each mutation:\n"
    "1. How does ONE amino acid change cause disease?\n"
    "2. What is the molecular mechanism?\n"
    "3. Is there a drug that targets this specific mutation?\n"
    "4. How common is this mutation in the population?\n\n"
    "Then explain: why are some single-letter changes devastating "
    "while others have no effect? Use an analogy."
)
print(result)
