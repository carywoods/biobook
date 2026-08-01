#!/usr/bin/env python3
"""
Chapter 5, Script 3 -- AI Version
Motif search + AI explains what the motifs mean biologically.
"""

import os
import re

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

def find_motifs(seq, pattern):
    return [(m.start(), m.group()) for m in re.finditer(pattern, seq, re.IGNORECASE)]

protein = "MALWMRLLPLLALLALWGPDPAAAFVNQHLCGSHLVEALYLVCGERGFFYTPKT"
motifs = {"N-glycosylation": r"N[^P][ST][^P]", "Phosphorylation": r"[ST]..[DE]", "Dibasic cleavage": r"KR|RR"}

print(f"Protein: {protein}\n")
found = {}
for name, pattern in motifs.items():
    matches = find_motifs(protein, pattern)
    found[name] = matches
    if matches:
        print(f"{name}: {len(matches)} match(es)")
        for pos, m in matches:
            print(f"  Position {pos}: {m}")

print("\n--- AI: What do these protein motifs tell us? ---\n")
motif_summary = "\n".join(f"  {n}: {len(m)} matches" for n, m in found.items())
result = ask_ai(
    f"I found these motifs in a protein sequence:\n{motif_summary}\n\n"
    f"Protein: {protein}\n\n"
    "Please explain:\n"
    "1. What does N-glycosylation mean? Why does the cell add sugar to proteins?\n"
    "2. What is a dibasic cleavage site? What happens there?\n"
    "3. Based on these motifs, what kind of protein might this be?\n"
    "4. How do scientists use motif databases like PROSITE or Pfam?\n\n"
    "This protein is actually proinsulin. Can you explain its processing?"
)
print(result)
