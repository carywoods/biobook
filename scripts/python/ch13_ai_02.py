#!/usr/bin/env python3
"""
Chapter 13, Script 2 -- AI Version
Error handling + AI helps debug file processing issues.
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

# Simulate common bioinformatics errors
errors = [
    {"file": "sample.fasta", "error": "FileNotFoundError", "detail": "No such file or directory"},
    {"file": "data.vcf", "error": "ValueError", "detail": "could not convert string to float: '.'"},
    {"file": "sequences.fq", "error": "UnicodeDecodeError", "detail": "'utf-8' codec can't decode byte 0x89"},
    {"file": "genome.bam", "error": "PermissionError", "detail": "Permission denied"},
]

print("Common bioinformatics file errors:")
for e in errors:
    print(f"  {e['file']}: {e['error']} -- {e['detail']}")

print("\n--- AI: Help me handle these errors ---\n")
error_text = "\n".join(f"  {e['file']}: {e['error']} ({e['detail']})" for e in errors)
result = ask_ai(
    f"I'm building a bioinformatics pipeline and keep hitting these errors:\n\n{error_text}\n\n"
    "For each error:\n"
    "1. What causes it?\n"
    "2. How should I handle it in Python? (try/except pattern)\n"
    "3. Should I skip the file, retry, or abort?\n"
    "4. What's the best practice for logging errors in pipelines?\n\n"
    "Also explain:\n"
    "- Why might a FASTQ file fail to decode as UTF-8?\n"
    "- What does a '.' mean in a VCF file and why does it break parsing?\n"
    "- How do production pipelines handle thousands of files with occasional errors?\n\n"
    "Give me Python code for a robust file processor."
)
print(result)
