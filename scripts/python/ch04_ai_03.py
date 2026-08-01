#!/usr/bin/env python3
"""
Chapter 4, Script 3 -- AI Version
Write FASTA + AI helps design experiment with the sequences.
"""

import os
from Bio.SeqRecord import SeqRecord
from Bio.Seq import Seq
from Bio import SeqIO

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

sequences = [
    SeqRecord(Seq("ATGGTGCATCTGACTCCTGAGGAGAAGTCTGCCGTTACTGCCCTGTGGGGCAAGGTGAAC"), id="seq001", description="hemoglobin beta fragment 1"),
    SeqRecord(Seq("GTGGATGAAGTTGGTGGTGAGGCCCTGGGCAGGCTGCTGGTGGTCTACCCTTGGACCCAG"), id="seq002", description="hemoglobin beta fragment 2"),
    SeqRecord(Seq("AGGTTCTTTGAGTCCTTTGGGGATCTGTCCACTCCTGATGCTGTTATGGGCAACCCTAAG"), id="seq003", description="hemoglobin beta fragment 3"),
]

output_file = "/tmp/output.fasta"
SeqIO.write(sequences, output_file, "fasta")
print(f"Wrote {len(sequences)} sequences to {output_file}")

seq_text = "\n".join(f"  {r.id}: {r.seq}" for r in sequences)

print("\n--- AI: What can we do with these sequences? ---\n")
result = ask_ai(
    f"I wrote {len(sequences)} DNA sequences to a FASTA file:\n{seq_text}\n\n"
    "As a bioinformatics instructor, suggest:\n"
    "1. What experiments could a student design with these sequences?\n"
    "2. What databases should they search? (BLAST, Ensembl, etc.)\n"
    "3. If these are fragments of the same gene, what's the next step to assemble them?\n\n"
    "Give 3 concrete next steps a freshman could follow."
)
print(result)
os.remove(output_file)
