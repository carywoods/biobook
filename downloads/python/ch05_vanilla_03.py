#!/usr/bin/env python3
"""
Chapter 5, Script 2 -- Vanilla Version
Generate random DNA and compare sequences.

Translated from: example7-3.pl and example7-4.pl
Concept: random generation, sequence comparison, percent identity
"""

import random

def random_dna(length: int) -> str:
    """Generate a random DNA sequence."""
    return "".join(random.choice("ATCG") for _ in range(length))


def percent_identity(seq1: str, seq2: str) -> float:
    """Calculate the percentage of identical positions."""
    matches = sum(1 for a, b in zip(seq1, seq2) if a == b)
    return matches / min(len(seq1), len(seq2)) * 100


# --- Main program ---
random.seed(42)

# Generate random sequences
print("Generating 6 random DNA sequences (20-30 bases each):\n")
sequences = []
for i in range(6):
    length = random.randint(20, 30)
    seq = random_dna(length)
    sequences.append(seq)
    print(f"  Seq {i+1} ({length} bp): {seq}")

# Compare all pairs
print("\nPairwise percent identity:")
print("-" * 40)
for i in range(len(sequences)):
    for j in range(i + 1, len(sequences)):
        pid = percent_identity(sequences[i], sequences[j])
        print(f"  Seq {i+1} vs Seq {j+1}: {pid:.1f}%")

# Average identity
identities = []
for i in range(len(sequences)):
    for j in range(i + 1, len(sequences)):
        identities.append(percent_identity(sequences[i], sequences[j]))

print(f"\nAverage pairwise identity: {sum(identities)/len(identities):.1f}%")
print(f"Expected for random DNA: ~25% (1/4 bases match by chance)")
