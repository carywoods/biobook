#!/usr/bin/env python3
"""
Chapter 14, Script 1 -- AI Version
Capstone: AI-assisted variant-to-drug pipeline.

Same analysis as vanilla, but AI provides deeper interpretation.
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

print("=" * 60)
print("CAPSTONE: AI-Assisted Variant-to-Drug Analysis")
print("=" * 60)

gene = "BRAF"
variant = "V600E"
print(f"\nGene: {gene}, Variant: {variant}")
print(f"Wild-type: GTG (Valine) -> Mutant: GAG (Glutamic acid)")

print("\n--- AI: Full clinical interpretation ---\n")
result = ask_ai(
    f"I'm analyzing the {gene} {variant} variant for a capstone project.\n\n"
    f"Variant: c.1799T>A (GTG->GAG, Valine->Glutamic acid)\n"
    f"Gene: BRAF (serine/threonine-protein kinase B-Raf)\n"
    f"Chromosome: 7q34\n\n"
    "Please provide a comprehensive analysis:\n\n"
    "1. MOLECULAR MECHANISM:\n"
    "   - How does V600E change the protein's structure?\n"
    "   - Why does this make the kinase constitutively active?\n\n"
    "2. CLINICAL SIGNIFICANCE:\n"
    "   - What cancers carry this mutation?\n"
    "   - What is the prognosis difference with vs without this mutation?\n\n"
    "3. THERAPEUTIC TARGETING:\n"
    "   - What drugs target BRAF V600E?\n"
    "   - How do they work (mechanism of action)?\n"
    "   - What is resistance and why does it develop?\n\n"
    "4. BIOINFORMATICS WORKFLOW:\n"
    "   - If I wanted to find this variant in patient sequencing data,\n"
    "     what tools would I use? (aligner, caller, annotator)\n\n"
    "Write like a clinical genetics review article."
)
print(result)

print("\n--- AI: What would you research next? ---\n")
result = ask_ai(
    "Given the BRAF V600E analysis above:\n"
    "1. What are the top 3 open research questions about this variant?\n"
    "2. If you had a patient's whole genome sequence, what else would you look for?\n"
    "3. How is AI changing cancer genomics today?\n\n"
    "Be specific and cite real approaches."
)
print(result)
