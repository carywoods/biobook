#!/usr/bin/env python3
"""
Chapter 12, Script 1 -- AI Version
PubMed search + AI summarizes the literature.
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

# Simulated PubMed results for BRCA1 cancer therapy
papers = [
    {"pmid": "12345678", "title": "BRCA1 mutations and PARP inhibitor sensitivity in breast cancer", "year": 2023},
    {"pmid": "12345679", "title": "Targeting BRCA1-deficient tumors with platinum chemotherapy", "year": 2022},
    {"pmid": "12345680", "title": "BRCA1 as a biomarker for immunotherapy response", "year": 2024},
]

print(f"PubMed search: BRCA1 cancer therapy")
print(f"Found {len(papers)} recent papers:")
for p in papers:
    print(f"  [{p['year']}] {p['title']} (PMID: {p['pmid']})")

print("\n--- AI: Summarize this research area ---\n")
paper_text = "\n".join(f"  [{p['year']}] {p['title']}" for p in papers)
result = ask_ai(
    f"I searched PubMed for 'BRCA1 cancer therapy' and found these papers:\n{paper_text}\n\n"
    "Please:\n"
    "1. Write a 3-sentence summary of this research area\n"
    "2. What is the main therapeutic strategy for BRCA1-mutant cancers?\n"
    "3. What are PARP inhibitors and how do they work?\n"
    "4. What are the open questions in this field?\n"
    "5. Suggest 3 follow-up search queries to explore further\n\n"
    "Write like a review article introduction -- concise and authoritative."
)
print(result)
