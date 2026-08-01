#!/usr/bin/env python3
"""
Chapter 7, Script 3 -- AI Version
Gene Ontology + AI explains pathways and drug targets.
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

genes = ["BRCA1", "TP53", "KRAS", "PTEN"]
processes = ["DNA repair", "apoptosis", "signal transduction", "cell proliferation"]

print("Key differentially expressed genes and their functions:")
for g, p in zip(genes, processes):
    print(f"  {g}: {p}")

print("\n--- AI: What pathway connects these genes? ---\n")
result = ask_ai(
    f"In a cancer experiment, these genes were differentially expressed:\n"
    f"- BRCA1 (DNA repair) -- upregulated\n"
    f"- TP53 (apoptosis) -- upregulated\n"
    f"- KRAS (signal transduction) -- downregulated\n"
    f"- PTEN (tumor suppressor) -- downregulated\n\n"
    "Please explain:\n"
    "1. What biological pathway connects these genes?\n"
    "2. Are these changes consistent with a treatment working or failing?\n"
    "3. Which of these genes are known drug targets?\n"
    "4. What is the PI3K/AKT pathway and how does PTEN regulate it?\n\n"
    "Draw a simple pathway diagram using text arrows."
)
print(result)
