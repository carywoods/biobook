#!/usr/bin/env python3
"""
Chapter 7, Script 2 -- Vanilla Version
Volcano plot visualization for differential expression.

Concept: matplotlib, scatter plots, statistical significance visualization
"""

import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

np.random.seed(42)
n_genes = 200

# Simulate log2 fold changes and p-values
# Most genes: no change
log2fc = np.random.normal(0, 0.5, n_genes)
# Some genes: real changes
log2fc[0:10] = np.random.uniform(1.5, 4, 10)    # upregulated
log2fc[10:20] = np.random.uniform(-4, -1.5, 10)  # downregulated

# P-values: significant for changed genes, random for others
neg_log_p = np.random.exponential(0.5, n_genes)
neg_log_p[0:10] = np.random.uniform(3, 10, 10)   # significant
neg_log_p[10:20] = np.random.uniform(3, 10, 10)  # significant

# Classify
colors = []
for i in range(n_genes):
    if abs(log2fc[i]) > 1 and neg_log_p[i] > 1.3:  # 1.3 = -log10(0.05)
        colors.append("red" if log2fc[i] > 0 else "blue")
    else:
        colors.append("gray")

# Plot
fig, ax = plt.subplots(figsize=(8, 6))
ax.scatter(log2fc, neg_log_p, c=colors, alpha=0.6, s=20)
ax.axhline(y=1.3, color='black', linestyle='--', alpha=0.3, label='p=0.05')
ax.axvline(x=-1, color='black', linestyle='--', alpha=0.3)
ax.axvline(x=1, color='black', linestyle='--', alpha=0.3)
ax.set_xlabel('log2(Fold Change)')
ax.set_ylabel('-log10(p-value)')
ax.set_title('Volcano Plot: Differential Expression')
ax.legend(['p=0.05', 'Upregulated', 'Downregulated', 'Not significant'],
          loc='upper right')

outfile = '/tmp/volcano.png'
plt.savefig(outfile, dpi=150, bbox_inches='tight')
print(f"Volcano plot saved to {outfile}")
print(f"Total genes: {n_genes}")
print(f"Upregulated (red): {sum(1 for c in colors if c == 'red')}")
print(f"Downregulated (blue): {sum(1 for c in colors if c == 'blue')}")
print(f"Not significant (gray): {sum(1 for c in colors if c == 'gray')}")
