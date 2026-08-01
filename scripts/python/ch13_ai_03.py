#!/usr/bin/env python3
"""
Chapter 13, Script 3 -- AI Version
Pipeline design + AI helps design and optimize the workflow.
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

# Pipeline design
pipeline_steps = [
    {"step": 1, "name": "Quality Control", "tool": "FastQC", "input": "raw FASTQ", "output": "QC report"},
    {"step": 2, "name": "Trimming", "tool": "Trimmomatic", "input": "raw FASTQ", "output": "trimmed FASTQ"},
    {"step": 3, "name": "Alignment", "tool": "BWA/BOWTIE2", "input": "trimmed FASTQ", "output": "BAM file"},
    {"step": 4, "name": "Quantification", "tool": "featureCounts", "input": "BAM file", "output": "count matrix"},
    {"step": 5, "name": "Differential Expression", "tool": "DESeq2", "input": "count matrix", "output": "gene list"},
]

print("RNA-seq Pipeline Design:")
for s in pipeline_steps:
    print(f"  Step {s['step']}: {s['name']}")
    print(f"    Tool: {s['tool']}")
    print(f"    {s['input']} -> {s['output']}")

print("\n--- AI: Help me build this pipeline ---\n")
result = ask_ai(
    "I'm designing an RNA-seq pipeline for a college bioinformatics course:\n\n"
    "Step 1: FastQC (quality control)\n"
    "Step 2: Trimmomatic (adapter trimming)\n"
    "Step 3: BWA (alignment to reference genome)\n"
    "Step 4: featureCounts (gene quantification)\n"
    "Step 5: DESeq2 (differential expression)\n\n"
    "Please:\n"
    "1. Explain each step in one sentence for a freshman\n"
    "2. What are the key parameters for each tool?\n"
    "3. How do I check if each step succeeded?\n"
    "4. What are common failure modes and how do I debug them?\n"
    "5. How would I run this on 100 samples? (parallelization)\n"
    "6. How could I use an LLM to automate the QC interpretation?\n\n"
    "Give me a Snakemake skeleton for this pipeline."
)
print(result)
