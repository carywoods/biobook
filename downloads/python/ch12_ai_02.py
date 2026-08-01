#!/usr/bin/env python3
"""
Chapter 12, Script 2 -- AI Version
Knowledge base + AI generates hypotheses from gene lists.
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

upregulated = ["BRCA1", "TP53", "ATM", "CHEK2"]
downregulated = ["KRAS", "MYC", "CDK6"]
print("Differential expression results:")
print(f"  Upregulated: {upregulated}")
print(f"  Downregulated: {downregulated}")

print("\n--- AI: Generate hypotheses from this gene list ---\n")
result = ask_ai(
    f"In a cancer treatment experiment, these genes changed:\n\n"
    f"Upregulated: {', '.join(upregulated)}\n"
    f"Downregulated: {', '.join(downregulated)}\n\n"
    "As a bioinformatics researcher, generate 3 testable hypotheses:\n\n"
    "For each hypothesis:\n"
    "1. State the hypothesis clearly\n"
    "2. Which genes support it?\n"
    "3. What experiment would test it?\n"
    "4. What result would confirm or reject it?\n\n"
    "Also:\n"
    "- Are any of these genes in the same pathway?\n"
    "- Is there a known drug that targets this combination?\n"
    "- What would you search on PubMed next?\n\n"
    "Think like a scientist, explain like a teacher."
)
print(result)
