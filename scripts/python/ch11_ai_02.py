#!/usr/bin/env python3
"""
Chapter 11, Script 2 -- AI Version
Spatial transcriptomics + AI explains tissue organization.
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

print("Spatial transcriptomics results:")
print("  Tissue section with 50 cells")
print("  Center: T-cells (CD3D high) -- immune infiltrate")
print("  Edge: Epithelial cells (EPCAM high) -- tissue boundary")

print("\n--- AI: What is spatial transcriptomics? ---\n")
result = ask_ai(
    "I analyzed a tissue section with spatial transcriptomics:\n\n"
    "  Center of tissue: T-cells (CD3D high)\n"
    "  Edge of tissue: Epithelial cells (EPCAM high)\n\n"
    "Please explain:\n"
    "1. What is spatial transcriptomics? How is it different from single-cell RNA-seq?\n"
    "2. Why does cell location matter? Can't we just dissociate the tissue?\n"
    "3. What does it mean that T-cells are in the center? (Think: tumor microenvironment)\n"
    "4. What technologies exist for spatial transcriptomics? (Visium, MERFISH, etc.)\n"
    "5. How might spatial data help in cancer diagnosis?\n\n"
    "Explain for a college student who has seen a microscope but never a sequencer."
)
print(result)
