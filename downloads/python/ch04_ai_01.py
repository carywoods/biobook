#!/usr/bin/env python3
"""
Chapter 4, Script 1 -- AI Version
Parse a GenBank file, then use AI to interpret the biological record.

Same parsing logic as vanilla, but AI explains what the annotation means.
Concept: file formats, structured data, Bio.SeqIO, AI-assisted annotation reading
"""

import os
import tempfile
from Bio import SeqIO

try:
    from openai import OpenAI
    client = OpenAI(
        api_key=os.environ.get("OPENAI_API_KEY", ""),
        base_url=os.environ.get("OPENAI_BASE_URL", "https://openrouter.ai/api/v1"),
    )
    AI_AVAILABLE = True
except ImportError:
    AI_AVAILABLE = False
    print("Note: Install openai package for AI features (pip install openai)\n")


def ask_ai(prompt: str) -> str:
    if not AI_AVAILABLE:
        return "(AI not available -- set OPENAI_API_KEY environment variable)"
    response = client.chat.completions.create(
        model=os.environ.get("OPENAI_MODEL", "google/gemini-2.5-flash"),
        messages=[{"role": "user", "content": prompt}],
        temperature=0.3,
    )
    return response.choices[0].message.content


SAMPLE_GENBANK = """\
LOCUS       SAMPLE_SEQ              576 bp    DNA     linear   PRI 01-JAN-2026
DEFINITION  Homo sapiens hemoglobin subunit beta (HBB) partial sequence.
ACCESSION   SAMPLE001
VERSION     SAMPLE001.1
KEYWORDS    .
SOURCE      Homo sapiens
  ORGANISM  Homo sapiens
            Eukaryota; Metazoa; Chordata; Craniata; Vertebrata; Euteleostomi;
            Mammalia; Eutheria; Euarchontoglires; Primates; Haplorrhini;
            Catarrhini; Hominidae; Homo.
FEATURES             Location/Qualifiers
     source          1..576
                     /organism="Homo sapiens"
                     /mol_type="genomic DNA"
     gene            1..576
                     /gene="HBB"
     CDS             1..576
                     /gene="HBB"
                     /product="hemoglobin subunit beta"
                     /translation="MVHLTPEEKSAVTALWGKVNVDEVGGEALGRLLVVYPWTQRFFES
                     FGDLSTPDAVMGNPKVKAHGKKVLGAFSDGLAHLDNLKGTFATLSELHCDKLHVDPE
                     NFRLLGNVLVCVLAHHFGKEFTPPVQAAYQKVVAGVANALAHKYH"
ORIGIN
        1 atggtgcatc tgactcctga ggagaagtct gccgttactg ccctgtgggg caaggtgaac
       61 gtggatgaag ttggtggtga ggccctgggc aggctgctgg tggtctaccc ttggacccag
      121 aggttctttg agtcctttgg ggatctgtcc actcctgatg ctgttatggg caaccctaag
      181 gtgaaggctc atggcaagaa agtgctcggt gcctttagtg atggcctggc tcacctggac
      241 aacctcaagg gcacctttgc cacactgagt gagctgcact gtgacaagct gcacgtggat
      301 cctgagaact tcagggagcc tctgccatgc tggatacatt catcacccag aatccaggac
      361 tccagccttc tgggcatcat tctgaccctc agctgcctcc aggtcctctg cttgagcttc
      421 cctttctgtt tcctgtccaa tctgctccca cccatggcta ttgagacact cttgttccct
      481 cctctgctga tgtggaagct gaaggtgctg gacttcatca cctttgccaa cctgctgggt
      541 gccctgtgga tgaactatgg caagaacttc atgacc
//
"""

# Write sample file
sample_file = os.path.join(tempfile.gettempdir(), "sample.gb")
with open(sample_file, "w") as f:
    f.write(SAMPLE_GENBANK)

# Parse with BioPython
record = SeqIO.read(sample_file, "genbank")
os.remove(sample_file)

# Display basics (same as vanilla)
print(f"ID:          {record.id}")
print(f"Description: {record.description}")
print(f"Length:       {len(record.seq)} bases")
print(f"Organism:     {record.annotations.get('organism', 'unknown')}")
print(f"Features:     {len(record.features)}")

# Collect feature summary for AI
feature_summary = []
for f in record.features:
    info = f"  {f.type}: {f.location}"
    if "gene" in f.qualifiers:
        info += f" (gene={f.qualifiers['gene'][0]})"
    if "product" in f.qualifiers:
        info += f" (product={f.qualifiers['product'][0]})"
    feature_summary.append(info)

features_text = "\n".join(feature_summary)

# --- AI: Explain the GenBank record ---
print("\n--- AI: What does this GenBank record tell us? ---\n")

result = ask_ai(
    f"I parsed a GenBank record for a DNA sequence. Here's the summary:\n\n"
    f"ID: {record.id}\n"
    f"Description: {record.description}\n"
    f"Organism: {record.annotations.get('organism', 'unknown')}\n"
    f"Length: {len(record.seq)} bases\n\n"
    f"Features:\n{features_text}\n\n"
    "Please explain for a college student:\n"
    "1. What is a GenBank record? Why do scientists submit sequences to it?\n"
    "2. What does each feature type mean (source, gene, CDS)?\n"
    "3. What is hemoglobin subunit beta, and why is it important?\n"
    "4. The CDS has a /translation qualifier. Why is that useful?\n\n"
    "Keep it brief and use analogies where possible."
)
print(result)

# --- AI: Downstream analysis suggestions ---
print("\n--- AI: What should we do next with this sequence? ---\n")

result = ask_ai(
    f"I have a GenBank record for human hemoglobin beta ({len(record.seq)} bases).\n"
    f"The protein sequence is:\n{record.features[-1].qualifiers.get('translation', [''])[0]}\n\n"
    "As a bioinformatics instructor, suggest 3 analyses a student could do next:\n"
    "1. A simple analysis they could do in 5 minutes\n"
    "2. A medium-difficulty analysis for a homework assignment\n"
    "3. A challenging analysis for a class project\n\n"
    "For each, name the tool or database they would use."
)
print(result)
