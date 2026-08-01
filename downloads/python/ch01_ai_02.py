#!/usr/bin/env python3
"""
Chapter 1, Script 2 -- AI Version
Toolkit setup + AI helps you get started.

Same setup check as vanilla, but AI provides personalized guidance.
"""

import os
import sys

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

# Check what's installed
installed = []
missing = []
for pkg, name in [("Bio", "BioPython"), ("pandas", "pandas"), ("numpy", "numpy"), ("matplotlib", "matplotlib"), ("openai", "openai")]:
    try:
        __import__(pkg)
        installed.append(name)
    except ImportError:
        missing.append(name)

print("Bioinformatics Toolkit Check")
print(f"  Python: {sys.version.split()[0]}")
print(f"  Installed: {', '.join(installed) if installed else 'none'}")
print(f"  Missing: {', '.join(missing) if missing else 'none'}")

if missing:
    print("\n--- AI: Help me set up my environment ---\n")
    result = ask_ai(
        f"I'm setting up a bioinformatics Python environment.\n"
        f"Installed: {', '.join(installed)}\n"
        f"Missing: {', '.join(missing)}\n\n"
        f"Python version: {sys.version.split()[0]}\n\n"
        "Please:\n"
        "1. Give me the exact pip command to install what's missing\n"
        "2. Should I use a virtual environment? Why?\n"
        "3. What is conda and should I use it instead of pip?\n"
        "4. What other tools would be useful for a bioinformatics student?\n\n"
        "Keep it simple -- I'm a beginner."
    )
    print(result)
else:
    print("\n--- AI: Everything is installed! ---\n")
    result = ask_ai(
        "I have BioPython, pandas, numpy, matplotlib, and openai installed.\n"
        "I'm a college student starting a bioinformatics course.\n\n"
        "Give me a 30-second tour: what does each package do and when will I use it?"
    )
    print(result)
