#!/usr/bin/env python3
"""
Chapter 6, Script 1 -- AI Version
Restriction enzyme mapping + AI explains cloning strategy.
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

ENZYMES = {"EcoRI": "GAATTC", "BamHI": "GGATCC", "HindIII": "AAGCTT", "XhoI": "CTCGAG", "PstI": "CTGCAG", "KpnI": "GGTACC"}

def find_sites(dna, enzymes):
    results = {}
    for name, site in enzymes.items():
        pos = [m.start() for m in re.finditer(site, dna, re.IGNORECASE)]
        if pos:
            results[name] = pos
    return results

dna = "GAATTCGAGCTCGGTACCCGGGGATCCTCTAGAGTCGACCTGCAGGCATGCAAGCTTGGCGTAATCATGGTCATAGCTGTTTCCTGTGTGAAATTGTTATCCGCTCACAATTCCACACAACATACGAGCCGGAAGCATAAAGTGTAAAGCCTGGGGTGCCTAATGAGTGAGCTAACTCACATTAATTGCGTTGCGCTCACTGCCCGCTTTCCAGTCGGGAAACCTGTCGTGCCAGCTGCATTAATGAATCGGCCAACGCGCGGGGAGAGGCGGTTTGCGTATTGGGCGCGAATTCCCT"

sites = find_sites(dna, ENZYMES)
print(f"Sequence ({len(dna)} bp):")
for enzyme, positions in sites.items():
    print(f"  {enzyme} ({ENZYMES[enzyme]}): position(s) {[p+1 for p in positions]}")

single_cutters = {e: p for e, p in sites.items() if len(p) == 1}
print(f"\nSingle cutters: {list(single_cutters.keys())}")

print("\n--- AI: Help me plan a cloning experiment ---\n")
enzyme_info = "\n".join(f"  {e}: {ENZYMES[e]} at {[p+1 for p in pos]}" for e, pos in sites.items())
result = ask_ai(
    f"I have a {len(dna)} bp plasmid with these restriction sites:\n{enzyme_info}\n\n"
    f"Single cutters: {list(single_cutters.keys())}\n\n"
    "I want to clone a gene into this plasmid. Please explain:\n"
    "1. What are single cutters and why are they important for cloning?\n"
    "2. If my gene has EcoRI sites, which enzyme should I use instead?\n"
    "3. Walk me through the cloning process step by step.\n"
    "4. What is 'ligation' and how does DNA ligase work?\n\n"
    "Explain for a college freshman who has never been in a lab."
)
print(result)
