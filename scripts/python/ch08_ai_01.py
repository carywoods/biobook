#!/usr/bin/env python3
"""
Chapter 8, Script 1 -- AI Version
PDB structure analysis + AI explains protein structure.
"""

import os
import urllib.request

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

def fetch_pdb(pdb_id, out="/tmp/pdb"):
    os.makedirs(out, exist_ok=True)
    fn = os.path.join(out, f"{pdb_id}.pdb")
    if not os.path.exists(fn):
        urllib.request.urlretrieve(f"https://files.rcsb.org/download/{pdb_id.upper()}.pdb", fn)
    return fn

def parse_chains(filename):
    chains = {}
    with open(filename) as f:
        for line in f:
            if line.startswith("ATOM"):
                chain = line[21]
                resname = line[17:20].strip()
                if chain not in chains:
                    chains[chain] = set()
                chains[chain].add(resname)
    return chains

pdb_id = "1HHO"
filename = fetch_pdb(pdb_id)
chains = parse_chains(filename)

print(f"PDB: {pdb_id} (Human oxy-hemoglobin)")
for chain_id, residues in chains.items():
    print(f"  Chain {chain_id}: {len(residues)} unique residues")

print("\n--- AI: What is this protein? ---\n")
result = ask_ai(
    f"I downloaded PDB structure {pdb_id} from RCSB.\n"
    f"It has {len(chains)} chains: {list(chains.keys())}\n\n"
    "Please explain:\n"
    "1. What is hemoglobin? What does it do in the body?\n"
    "2. Why does hemoglobin have multiple chains (subunits)?\n"
    "3. What is the difference between oxy- and deoxy-hemoglobin?\n"
    "4. How does the 3D structure relate to its function?\n"
    "5. What disease is caused by a single amino acid change in hemoglobin?\n\n"
    "Explain for a college freshman."
)
print(result)
