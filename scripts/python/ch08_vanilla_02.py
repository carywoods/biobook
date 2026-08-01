#!/usr/bin/env python3
"""
Chapter 8, Script 2 -- Vanilla Version
AlphaFold: AI predicts protein structure from sequence.

Concept: AlphaFold database, structure prediction, confidence scores
"""

import os
import urllib.request
import json


def fetch_alphafold(uniprot_id: str, out_dir: str = "/tmp/alphafold") -> dict:
    """Fetch AlphaFold prediction metadata for a protein."""
    os.makedirs(out_dir, exist_ok=True)
    url = f"https://alphafold.ebi.ac.uk/api/prediction/{uniprot_id}"
    try:
        response = urllib.request.urlopen(url)
        data = json.loads(response.read())
        return data[0] if data else {}
    except Exception as e:
        print(f"Error fetching {uniprot_id}: {e}")
        return {}


def download_pdb(url: str, filename: str) -> str:
    """Download a PDB file."""
    if not os.path.exists(filename):
        urllib.request.urlretrieve(url, filename)
    return filename


# --- Main program ---
# Human hemoglobin beta subunit
uniprot_id = "P68871"

print(f"Fetching AlphaFold prediction for {uniprot_id}...")
info = fetch_alphafold(uniprot_id)

if info:
    print(f"\nProtein: {info.get('uniprotId', 'unknown')}")
    print(f"Gene: {info.get('gene', 'unknown')}")
    print(f"Organism: {info.get('organismScientificName', 'unknown')}")
    print(f"Model confidence URL: {info.get('paeImageUrl', 'N/A')}")

    # Download the predicted structure
    pdb_url = info.get("pdbUrl")
    if pdb_url:
        pdb_file = download_pdb(pdb_url, f"/tmp/alphafold/{uniprot_id}.pdb")
        print(f"\nPredicted structure saved to: {pdb_file}")

        # Parse confidence scores from B-factor column
        confidences = []
        with open(pdb_file) as f:
            for line in f:
                if line.startswith("ATOM") and line[12:16].strip() == "CA":
                    bfactor = float(line[60:66])
                    confidences.append(bfactor)

        if confidences:
            avg_conf = sum(confidences) / len(confidences)
            print(f"\nConfidence scores (pLDDT):")
            print(f"  Average: {avg_conf:.1f}")
            print(f"  Min: {min(confidences):.1f}")
            print(f"  Max: {max(confidences):.1f}")

            # Interpret confidence
            high = sum(1 for c in confidences if c > 90)
            good = sum(1 for c in confidences if 70 < c <= 90)
            low = sum(1 for c in confidences if c <= 70)
            print(f"\n  Very high confidence (>90): {high} residues")
            print(f"  High confidence (70-90): {good} residues")
            print(f"  Low confidence (<=70): {low} residues")
else:
    print("Could not fetch AlphaFold data. Check the UniProt ID.")
