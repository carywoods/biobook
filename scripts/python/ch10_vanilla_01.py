#!/usr/bin/env python3
"""
Chapter 10, Script 1 -- Vanilla Version
Metagenomics: classifying sequences from a microbial community.

Concept: taxonomy, 16S rRNA, classification, diversity
"""

import random
from collections import Counter

# Simulated taxonomic classification results
# (In reality, this would come from Kraken2 or MetaPhlAn)
random.seed(42)

TAXA = {
    "Bacteroides": 0.25,
    "Faecalibacterium": 0.15,
    "Bifidobacterium": 0.12,
    "Lactobacillus": 0.08,
    "Roseburia": 0.07,
    "Eubacterium": 0.06,
    "Clostridium": 0.05,
    "Prevotella": 0.04,
    "Ruminococcus": 0.03,
    "Akkermansia": 0.02,
    "Escherichia": 0.01,
    "Other": 0.12,
}

# Generate classification results
n_reads = 1000
classifications = []
for taxon, abundance in TAXA.items():
    count = int(abundance * n_reads)
    classifications.extend([taxon] * count)

# Add noise
random.shuffle(classifications)

print(f"Metagenomic classification: {len(classifications)} reads")
print(f"\nTaxonomic composition:")
print("-" * 40)

counts = Counter(classifications)
for taxon, count in counts.most_common():
    pct = count / len(classifications) * 100
    bar = "#" * int(pct / 2)
    print(f"  {taxon:20s} {count:4d} ({pct:5.1f}%) {bar}")

# Diversity metrics
print(f"\nDiversity metrics:")
print(f"  Total reads: {len(classifications)}")
print(f"  Unique taxa: {len(counts)}")
print(f"  Most abundant: {counts.most_common(1)[0][0]} ({counts.most_common(1)[0][1]})")

# Shannon diversity index
import math
shannon = 0
for count in counts.values():
    p = count / len(classifications)
    if p > 0:
        shannon -= p * math.log(p)
print(f"  Shannon index: {shannon:.2f}")
print(f"  (Higher = more diverse, max for {len(counts)} taxa = {math.log(len(counts)):.2f})")
