#!/usr/bin/env python3
"""
Chapter 11, Script 1 -- Vanilla Version
Single-cell RNA-seq: clustering cell types.

Concept: single-cell basics, clustering, cell type annotation
"""

import numpy as np
from collections import Counter

# Simulated single-cell data: 100 cells, 5 genes
np.random.seed(42)
n_cells = 100
genes = ["CD3D", "CD19", "CD14", "EPCAM", "VIM"]

# Generate expression data for 4 cell types
cell_types = ["T-cell", "B-cell", "Monocyte", "Epithelial"]
true_labels = []
expression = []

for i in range(n_cells):
    if i < 30:  # T-cells
        true_labels.append("T-cell")
        expression.append([np.random.poisson(50), np.random.poisson(2), np.random.poisson(3), np.random.poisson(1), np.random.poisson(5)])
    elif i < 55:  # B-cells
        true_labels.append("B-cell")
        expression.append([np.random.poisson(3), np.random.poisson(45), np.random.poisson(2), np.random.poisson(1), np.random.poisson(4)])
    elif i < 80:  # Monocytes
        true_labels.append("Monocyte")
        expression.append([np.random.poisson(2), np.random.poisson(1), np.random.poisson(55), np.random.poisson(2), np.random.poisson(3)])
    else:  # Epithelial
        true_labels.append("Epithelial")
        expression.append([np.random.poisson(1), np.random.poisson(1), np.random.poisson(2), np.random.poisson(60), np.random.poisson(10)])

data = np.array(expression)

print(f"Single-cell dataset: {n_cells} cells x {len(genes)} genes")
print(f"Genes: {genes}")
print(f"True cell types: {Counter(true_labels)}")

# Show average expression per cell type
print(f"\nAverage expression by cell type:")
print(f"{'Cell Type':12s} {'  '.join(f'{g:>6s}' for g in genes)}")
print("-" * 50)
for ct in cell_types:
    mask = [i for i, l in enumerate(true_labels) if l == ct]
    means = data[mask].mean(axis=0)
    print(f"{ct:12s} {'  '.join(f'{m:6.1f}' for m in means)}")

# Identify marker genes (highest expression per type)
print(f"\nMarker genes:")
for ct in cell_types:
    mask = [i for i, l in enumerate(true_labels) if l == ct]
    means = data[mask].mean(axis=0)
    marker_idx = np.argmax(means)
    print(f"  {ct}: {genes[marker_idx]} (avg={means[marker_idx]:.1f})")
