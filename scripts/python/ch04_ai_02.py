#!/usr/bin/env python3
"""
Chapter 4, Script 2 -- AI Version
GenBank annotation + AI explains what each feature means biologically.
"""

import os
import tempfile
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

SAMPLE_GENBANK = """\
LOCUS       HBB_GENE                576 bp    DNA     linear   PRI 01-JAN-2026
DEFINITION  Homo sapiens hemoglobin subunit beta (HBB) partial sequence.
ACCESSION   SAMPLE001
SOURCE      Homo sapiens
  ORGANISM  Homo sapiens
            Eukaryota; Metazoa; Chordata; Craniata; Vertebrata; Euteleostomi;
            Mammalia; Eutheria; Primates; Haplorrhini; Hominidae; Homo.
FEATURES             Location/Qualifiers
     source          1..576
                     /organism="Homo sapiens"
     gene            1..576
                     /gene="HBB"
     CDS             1..576
                     /gene="HBB"
                     /product="hemoglobin subunit beta"
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

sample_file = os.path.join(tempfile.gettempdir(), "hbb.gb")
with open(sample_file, "w") as f:
    f.write(SAMPLE_GENBANK)
record = SeqIO.read(sample_file, "genbank")
os.remove(sample_file)

print(f"Parsed: {record.id} -- {record.description}")
print(f"Features: {len(record.features)}")

# Build feature summary
feature_text = ""
for f in record.features:
    feature_text += f"  {f.type}: {f.location}\n"
    for k, v in f.qualifiers.items():
        feature_text += f"    {k}: {v[0]}\n"

print("\n--- AI: What do these GenBank features mean? ---\n")
result = ask_ai(
    f"A GenBank record for {record.id} has these features:\n\n{feature_text}\n"
    "Explain for a college student:\n"
    "1. What is the difference between 'source', 'gene', and 'CDS' features?\n"
    "2. What does /mol_type='genomic DNA' tell us?\n"
    "3. Why is the CDS feature important? What would happen if it were wrong?\n"
    "4. How do scientists verify that a GenBank annotation is correct?\n\n"
    "Use the analogy of a library catalog entry."
)
print(result)
