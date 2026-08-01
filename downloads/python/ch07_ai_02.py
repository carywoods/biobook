#!/usr/bin/env python3
"""
Chapter 7, Script 2 -- AI Version
Volcano plot + AI explains what the plot means.
"""

import os
import numpy as np

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

# Simulate results
np.random.seed(42)
n = 200
log2fc = np.random.normal(0, 0.5, n)
log2fc[0:10] = np.random.uniform(1.5, 4, 10)
log2fc[10:20] = np.random.uniform(-4, -1.5, 10)
pval = np.random.exponential(0.5, n)
pval[0:20] = np.random.uniform(3, 10, 20)

up = sum(1 for i in range(n) if log2fc[i] > 1 and pval[i] > 1.3)
down = sum(1 for i in range(n) if log2fc[i] < -1 and pval[i] > 1.3)

print(f"Simulation: {n} genes, {up} upregulated, {down} downregulated")

print("\n--- AI: How do I read a volcano plot? ---\n")
result = ask_ai(
    f"I made a volcano plot from RNA-seq data:\n"
    f"- {n} genes tested\n"
    f"- {up} significantly upregulated (log2FC > 1, p < 0.05)\n"
    f"- {down} significantly downregulated (log2FC < -1, p < 0.05)\n\n"
    "Please explain:\n"
    "1. What does each axis of a volcano plot represent?\n"
    "2. Why is it called a 'volcano' plot?\n"
    "3. What do the genes in the top-right corner mean biologically?\n"
    "4. How do scientists decide the cutoffs for 'significant'?\n"
    "5. What is the difference between statistical significance and biological significance?\n\n"
    "Use analogies for a college freshman."
)
print(result)
