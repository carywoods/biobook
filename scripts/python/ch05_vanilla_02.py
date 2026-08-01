#!/usr/bin/env python3
"""
Chapter 5, Script 1 -- Vanilla Version
Mutate DNA randomly.

Translated from: example7-2.pl
Concept: random module, mutation simulation, probability
"""

import random

def mutate_dna(dna: str, mutation_rate: float = 0.1) -> str:
    """Randomly mutate bases in a DNA sequence."""
    bases = ["A", "T", "G", "C"]
    mutated = []
    for base in dna:
        if random.random() < mutation_rate:
            # Pick a different base
            choices = [b for b in bases if b != base]
            new_base = random.choice(choices)
            mutated.append(new_base)
        else:
            mutated.append(base)
    return "".join(mutated)


def count_mutations(original: str, mutated: str) -> int:
    """Count the number of positions that differ."""
    return sum(1 for a, b in zip(original, mutated) if a != b)


# --- Main program ---
random.seed(42)  # For reproducibility

dna = "A" * 30  # Easy to see mutations
print(f"Original: {dna}")

# Mutate at different rates
for rate in [0.05, 0.1, 0.2, 0.5]:
    mutated = mutate_dna(dna, rate)
    changes = count_mutations(dna, mutated)
    print(f"  Rate {rate:.0%}: {mutated} ({changes} mutations)")

# Real-world example
print("\nReal sequence:")
original = "ATGGTGCATCTGACTCCTGAGGAGAAGTCTGCCGTTACTGCCCTGTGGGGCAAGGTGAAC"
mutated = mutate_dna(original, 0.05)
changes = count_mutations(original, mutated)
print(f"  Original: {original}")
print(f"  Mutated:  {mutated}")
print(f"  Changes:  {changes}/{len(original)} positions ({changes/len(original):.1%})")

# Show which positions changed
print("\n  Position-by-position:")
for i, (a, b) in enumerate(zip(original, mutated)):
    if a != b:
        print(f"    Position {i+1}: {a} -> {b}")
