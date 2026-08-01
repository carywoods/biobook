#!/usr/bin/env python3
"""
Chapter 9, Script 1 -- AI Version
VCF parsing + AI explains variants and disease risk.
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
    {"chrom": "chr7", "pos": 55191822, "id": "rs1212127", "ref": "T", "alt": "G", "af": 0.52, "gene": "BRAF"},
    {"chrom": "chr17", "pos": 41245466, "id": "rs80357906", "ref": "A", "alt": "G", "af": 0.01, "gene": "BRCA1"},
    {"chrom": "chr12", "pos": 25398284, "id": "rs121913529", "ref": "C", "alt": "T", "af": 0.02, "gene": "KRAS"},
]

print("Notable variants found:")
for v in variants:
    print(f"  {v['id']}: {v['ref']}>{v['alt']} in {v['gene']} (AF={v['af']:.2f})")

print("\n--- AI: What do these variants mean for health? ---\n")
var_text = "\n".join(f"  {v['id']}: {v['ref']}>{v['alt']} in {v['gene']}, allele frequency={v['af']}" for v in variants)
result = ask_ai(
    f"I found these genetic variants in a patient's genome:\n{var_text}\n\n"
    "Please explain:\n"
    "1. What does each variant do? Are they pathogenic or benign?\n"
    "2. What is the clinical significance of BRCA1 variants?\n"
    "3. What is pharmacogenomics? Could these variants affect drug response?\n"
    "4. How do genetic counselors use this information?\n\n"
    "Be sensitive -- this could be someone's real genetic data."
)
print(result)
