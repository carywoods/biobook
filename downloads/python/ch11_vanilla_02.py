#!/usr/bin/env python3
"""
Chapter 11, Script 2 -- Vanilla Version
Spatial transcriptomics: where are the cells?

Concept: spatial data, coordinates, gene expression in tissue
"""

import numpy as np

# Simulated spatial data: cells in a tissue section
np.random.seed(42)
n_cells = 50

# Cell positions (x, y coordinates)
x = np.random.uniform(0, 100, n_cells)
y = np.random.uniform(0, 100, n_cells)

# Gene expression: CD3D (T-cell) high in center, EPCAM (epithelial) high at edges
cd3d = np.where(np.sqrt((x-50)**2 + (y-50)**2) < 30, np.random.poisson(40, n_cells), np.random.poisson(5, n_cells))
epcam = np.where(np.sqrt((x-50)**2 + (y-50)**2) > 25, np.random.poisson(35, n_cells), np.random.poisson(3, n_cells))

print(f"Spatial transcriptomics: {n_cells} cells in tissue section")
print(f"  CD3D (T-cell marker): mean={cd3d.mean():.1f}, max={cd3d.max()}")
print(f"  EPCAM (epithelial): mean={epcam.mean():.1f}, max={epcam.max()}")

# Identify regions
center = np.sqrt((x-50)**2 + (y-50)**2) < 30
edge = ~center

print(f"\nCenter region ({center.sum()} cells):")
print(f"  CD3D mean: {cd3d[center].mean():.1f}")
print(f"  EPCAM mean: {epcam[center].mean():.1f}")

print(f"\nEdge region ({edge.sum()} cells):")
print(f"  CD3D mean: {cd3d[edge].mean():.1f}")
print(f"  EPCAM mean: {epcam[edge].mean():.1f}")

# Simple text visualization
print(f"\nSpatial map (CD3D high = T, EPCAM high = E, both = B):")
grid = [[" " for _ in range(20)] for _ in range(20)]
for i in range(n_cells):
    gx = min(int(x[i] / 5), 19)
    gy = min(int(y[i] / 5), 19)
    if cd3d[i] > 20 and epcam[i] > 20:
        grid[gy][gx] = "B"
    elif cd3d[i] > 20:
        grid[gy][gx] = "T"
    elif epcam[i] > 20:
        grid[gy][gx] = "E"
    else:
        grid[gy][gx] = "."

for row in grid:
    print("  " + "".join(row))
