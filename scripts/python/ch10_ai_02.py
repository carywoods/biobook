#!/usr/bin/env python3
"""
Chapter 10, Script 2 -- AI Version
Microbiome comparison + AI explains health implications.
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

print("Three microbiome profiles:")
print("  Healthy: Bacteroides 25%, Faecalibacterium 15%, Bifidobacterium 12%")
print("  Antibiotic: Enterococcus 30%, Clostridium 25%, E.coli 20%")
print("  Disease: Fusobacterium 20%, Porphyromonas 18%, Prevotella 15%")

print("\n--- AI: What do these differences tell us? ---\n")
result = ask_ai(
    "I compared microbiomes from three conditions:\n\n"
    "Healthy: Bacteroides 25%, Faecalibacterium 15%, Bifidobacterium 12%\n"
    "Post-antibiotic: Enterococcus 30%, Clostridium 25%, E.coli 20%\n"
    "Disease: Fusobacterium 20%, Porphyromonas 18%, Prevotella 15%\n\n"
    "Please explain:\n"
    "1. Why does antibiotic treatment shift the microbiome so dramatically?\n"
    "2. Fusobacterium is enriched in disease -- what disease and why?\n"
    "3. How do scientists use microbiome data to diagnose disease?\n"
    "4. What is a 'probiotic' and can it restore a healthy microbiome?\n\n"
    "Explain for a college student interested in health."
)
print(result)
