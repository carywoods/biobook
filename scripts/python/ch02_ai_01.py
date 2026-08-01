#!/usr/bin/env python3
"""
Chapter 2, Script 1 -- AI Version
Store and print a DNA sequence, then use an LLM to analyze it.

Same task as vanilla, but adds AI interpretation.
Concept: variables, strings, print(), basic LLM prompting
"""

import os

# Try to import the AI client -- works with OpenAI-compatible APIs
try:
    from openai import OpenAI
    client = OpenAI(
        api_key=os.environ.get("OPENAI_API_KEY", ""),
        base_url=os.environ.get("OPENAI_BASE_URL", "https://openrouter.ai/api/v1"),
    )
    AI_AVAILABLE = True
except ImportError:
    AI_AVAILABLE = False
    print("Note: Install openai package for AI features (pip install openai)")
    print("Running in offline mode.\n")


def ask_ai(prompt: str) -> str:
    """Send a prompt to the LLM and return the response."""
    if not AI_AVAILABLE:
        return "(AI not available -- set OPENAI_API_KEY environment variable)"
    response = client.chat.completions.create(
        model=os.environ.get("OPENAI_MODEL", "google/gemini-2.5-flash"),
        messages=[{"role": "user", "content": prompt}],
        temperature=0.3,
    )
    return response.choices[0].message.content


# --- Same code as the vanilla version ---
dna = "ACGGGAGGACGGGAAAATTACTACGGCATTAGC"
print(dna)
print(f"Length: {len(dna)}")
print(f"First base: {dna[0]}")
print(f"Last base: {dna[-1]}")
print(f"First 10 bases: {dna[:10]}")

# --- Now add AI analysis ---
print("\n--- AI Analysis ---\n")

# Ask the LLM to analyze the sequence
result = ask_ai(
    f"I have a DNA sequence: {dna}\n\n"
    "Please tell me:\n"
    "1. What is the GC content (percentage of G and C bases)?\n"
    "2. Is this likely a coding sequence or random DNA? Why?\n"
    "3. What organism might this come from?\n\n"
    "Keep your answer brief and suitable for a college freshman."
)
print(result)

# Ask for a biological interpretation
print("\n--- Biological Context ---\n")
result = ask_ai(
    f"Given this DNA sequence: {dna}\n\n"
    "If this were part of a gene, what kinds of proteins might it help encode? "
    "Explain in one paragraph, using language a non-biology major would understand."
)
print(result)
