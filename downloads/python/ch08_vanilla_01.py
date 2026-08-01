#!/usr/bin/env python3
"""
Chapter 8, Script 1 -- Vanilla Version
Working with PDB files and protein structure.

Translated from: example11-1.pl, example11-2.pl, example11-5.pl
Concept: PDB format, file navigation, structure parsing
"""

import os
import urllib.request


def fetch_pdb(pdb_id: str, output_dir: str = "/tmp/pdb") -> str:
    """Download a PDB file from RCSB."""
    os.makedirs(output_dir, exist_ok=True)
    filename = os.path.join(output_dir, f"{pdb_id}.pdb")
    if os.path.exists(filename):
        return filename
    url = f"https://files.rcsb.org/download/{pdb_id.upper()}.pdb"
    print(f"Downloading {pdb_id} from RCSB...")
    urllib.request.urlretrieve(url, filename)
    return filename


def parse_pdb_atoms(filename: str) -> list:
    """Extract ATOM records from a PDB file."""
    atoms = []
    with open(filename) as f:
        for line in f:
            if line.startswith("ATOM"):
                atom = {
                    "serial": int(line[6:11]),
                    "name": line[12:16].strip(),
                    "resname": line[17:20].strip(),
                    "chain": line[21],
                    "resseq": int(line[22:26]),
                    "x": float(line[30:38]),
                    "y": float(line[38:46]),
                    "z": float(line[46:54]),
                }
                atoms.append(atom)
    return atoms


def get_chains(atoms: list) -> dict:
    """Group atoms by chain."""
    chains = {}
    for atom in atoms:
        chain = atom["chain"]
        if chain not in chains:
            chains[chain] = []
        chains[chain].append(atom)
    return chains


# --- Main program ---
pdb_id = "1HHO"  # Human oxy-hemoglobin
filename = fetch_pdb(pdb_id)

print(f"PDB file: {filename}")

atoms = parse_pdb_atoms(filename)
print(f"Total atoms: {len(atoms)}")

chains = get_chains(atoms)
print(f"\nChains: {len(chains)}")
for chain_id, chain_atoms in chains.items():
    residues = set(a["resseq"] for a in chain_atoms)
    print(f"  Chain {chain_id}: {len(chain_atoms)} atoms, {len(residues)} residues")

# Show first few atoms
print(f"\nFirst 5 atoms:")
for atom in atoms[:5]:
    print(f"  {atom['serial']:4d} {atom['name']:4s} {atom['resname']:3s} "
          f"{atom['chain']}{atom['resseq']:4d} "
          f"({atom['x']:.1f}, {atom['y']:.1f}, {atom['z']:.1f})")
