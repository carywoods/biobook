#!/usr/bin/env python3
"""
Chapter 6, Script 3 -- AI Version
Debugging exercise + AI helps find and explain the bugs.
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

# This code has intentional bugs for the debugging exercise
buggy_code = '''
dna = "CGACGTCTTCTAAGGCGA"
print("DNA: " + DNA)  # Bug 1: wrong case

complement = {"A": "T", "T": "A", "G": "C", "C": "G"}
comp_dna = ""
for base in dna:
    if base = "A":  # Bug 2: assignment instead of comparison
        comp_dna += complement[base]
    else
        comp_dna += "N"  # Bug 3: missing colon

print("Complement: " + comp_dna)
'''

print("=== BUGGY CODE ===")
print(buggy_code)

print("--- AI: Help me debug this code ---\n")
result = ask_ai(
    f"I'm a student learning Python for bioinformatics. "
    f"This code is supposed to find the complement of a DNA sequence, "
    f"but it has bugs:\n\n{buggy_code}\n\n"
    "Please:\n"
    "1. Identify each bug and explain WHY it's wrong\n"
    "2. Show the corrected code\n"
    "3. Explain the Python rule that each bug violates\n"
    "4. Give me a tip to avoid each type of bug in the future\n\n"
    "Be encouraging -- I'm still learning!"
)
print(result)
