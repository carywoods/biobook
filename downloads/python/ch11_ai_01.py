#!/usr/bin/env python3
"""
Chapter 11, Script 1 -- AI Version
Single-cell analysis + AI explains cell types and markers.
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

print("Single-cell RNA-seq results:")
print("  100 cells, 5 marker genes")
print("  Identified 4 cell types:")
print("    T-cells (30): high CD3D")
print("    B-cells (25): high CD19")
print("    Monocytes (25): high CD14")
print("    Epithelial (20): high EPCAM")

print("\n--- AI: What are these cell types and why do they matter? ---\n")
result = ask_ai(
    "I analyzed single-cell RNA-seq data and found 4 cell types:\n\n"
    "  T-cells (30 cells): marker gene CD3D\n"
    "  B-cells (25 cells): marker gene CD19\n"
    "  Monocytes (25 cells): marker gene CD14\n"
    "  Epithelial (20 cells): marker gene EPCAM\n\n"
    "Please explain:\n"
    "1. What does each cell type do in the immune system?\n"
    "2. What is CD3D? Why is it a T-cell marker?\n"
    "3. What is single-cell RNA-seq and how is it different from bulk RNA-seq?\n"
    "4. What is 10x Genomics and how does it work?\n"
    "5. How would you name a new cluster with no known markers?\n\n"
    "Explain for a college freshman."
)
print(result)
