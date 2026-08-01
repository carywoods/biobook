#!/usr/bin/env python3
"""
Chapter 10, Script 2 -- Vanilla Version
Comparing microbiome diversity across samples.

Concept: beta diversity, PCoA, sample comparison
"""

import math

# Three samples: healthy, antibiotic-treated, disease
samples = {
    "Healthy": {"Bacteroides": 25, "Faecalibacterium": 15, "Bifidobacterium": 12, "Lactobacillus": 8, "Roseburia": 7, "Other": 33},
    "Antibiotic": {"Bacteroides": 5, "Enterococcus": 30, "Clostridium": 25, "Escherichia": 20, "Other": 20},
    "Disease": {"Fusobacterium": 20, "Porphyromonas": 18, "Prevotella": 15, "Bacteroides": 10, "Other": 37},
}

print("Microbiome comparison across conditions:")
print("=" * 50)

# Shannon diversity for each
def shannon(counts):
    total = sum(counts.values())
    return -sum((c/total) * math.log(c/total) for c in counts.values() if c > 0)

for name, comp in samples.items():
    h = shannon(comp)
    print(f"\n{name} (Shannon={h:.2f}):")
    for taxon, pct in sorted(comp.items(), key=lambda x: -x[1]):
        bar = "#" * (pct // 2)
        print(f"  {taxon:20s} {pct:3d}% {bar}")

# Jaccard similarity between samples
def jaccard(s1, s2):
    set1 = set(k for k, v in s1.items() if v > 2)
    set2 = set(k for k, v in s2.items() if v > 2)
    intersection = set1 & set2
    union = set1 | set2
    return len(intersection) / len(union) if union else 0

print("\n\nPairwise similarity (Jaccard index):")
names = list(samples.keys())
for i in range(len(names)):
    for j in range(i+1, len(names)):
        sim = jaccard(samples[names[i]], samples[names[j]])
        print(f"  {names[i]} vs {names[j]}: {sim:.2f}")
