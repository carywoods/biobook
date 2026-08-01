#!/usr/bin/env python3
"""
Chapter 13, Script 1 -- AI Version
BLAST parsing + AI explains the biological significance of hits.
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

hits = [
    {"subject": "NM_007294.4 (BRCA1)", "identity": 99.85, "evalue": 0.0, "score": 1241},
    {"subject": "NM_007294.3 (BRCA1)", "identity": 99.70, "evalue": 0.0, "score": 1237},
    {"subject": "XM_006710328.4 (BRCA1)", "identity": 98.22, "evalue": 0.0, "score": 1204},
]

print("BLAST results (top 3 hits):")
for h in hits:
    print(f"  {h['subject']}: {h['identity']}% identity, E={h['evalue']}, score={h['score']}")

print("\n--- AI: What do these BLAST results mean? ---\n")
result = ask_ai(
    "I BLASTed a DNA sequence and got these top hits:\n\n"
    "  NM_007294.4 (BRCA1): 99.85% identity, E-value=0.0\n"
    "  NM_007294.3 (BRCA1): 99.70% identity, E-value=0.0\n"
    "  XM_006710328.4 (BRCA1): 98.22% identity, E-value=0.0\n\n"
    "Please explain:\n"
    "1. What is BLAST and how does it work? (Explain the algorithm simply)\n"
    "2. What does E-value = 0.0 mean? Is it really zero?\n"
    "3. Why are there multiple BRCA1 entries? What's the difference between NM_ and XM_?\n"
    "4. 99.85% identity over 675 bases -- how many bases differ?\n"
    "5. How would you cite this result in a paper?\n\n"
    "Explain for a student running BLAST for the first time."
)
print(result)
