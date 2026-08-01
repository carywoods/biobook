#!/usr/bin/env python3
"""
Chapter 14, Script 2 -- AI Version
Capstone: AI interprets the expression dashboard and suggests treatment.
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

upregulated = [("MYC", "oncogene", 4.0), ("VEGFA", "angiogenesis", 2.3), ("KRAS", "signal transduction", 1.6), ("EGFR", "growth factor receptor", 2.0)]
downregulated = [("TP53", "tumor suppressor", -1.7), ("BRCA1", "DNA repair", -2.0), ("CDH1", "cell adhesion", -1.6), ("PTEN", "tumor suppressor", -1.8)]

print("Cancer vs Normal: Expression Dashboard")
print(f"\nUpregulated: {', '.join(f'{g}({fc:+.1f})' for g, _, fc in upregulated)}")
print(f"Downregulated: {', '.join(f'{g}({fc:+.1f})' for g, _, fc in downregulated)}")

print("\n--- AI: Clinical interpretation and treatment recommendations ---\n")
result = ask_ai(
    "I analyzed gene expression in a cancer tumor vs normal tissue:\n\n"
    "Upregulated (overactive):\n" +
    "\n".join(f"  - {g} (log2FC={fc:+.1f}): {r}" for g, r, fc in upregulated) +
    "\n\nDownregulated (lost/silenced):\n" +
    "\n".join(f"  - {g} (log2FC={fc:+.1f}): {r}" for g, r, fc in downregulated) +
    "\n\nPlease provide:\n"
    "1. What type of cancer might this be? (based on the pattern)\n"
    "2. What pathways are dysregulated?\n"
    "3. Which upregulated genes are druggable? Name specific drugs.\n"
    "4. Could BRCA1 loss make this tumor sensitive to PARP inhibitors?\n"
    "5. What clinical trial would you recommend for this patient?\n\n"
    "Write as if you're a tumor board consultant presenting to oncologists."
)
print(result)

print("\n--- AI: Student reflection questions ---\n")
result = ask_ai(
    "For a bioinformatics student who just completed this capstone:\n"
    "1. What was the most important bioinformatics skill used in this analysis?\n"
    "2. If you could only use ONE tool for cancer genomics, what would it be?\n"
    "3. How will AI change cancer diagnosis in the next 10 years?\n"
    "4. What ethical considerations arise from genomic testing?\n\n"
    "Write as discussion questions for a class seminar."
)
print(result)
