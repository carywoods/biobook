#!/usr/bin/env python3
"""
Chapter 7, Script 1 -- Vanilla Version
RNA-seq count matrix analysis.

Concept: pandas DataFrames, gene expression, differential expression basics
"""

import pandas as pd
import numpy as np

# Create a sample count matrix (genes x samples)
np.random.seed(42)
genes = ["BRCA1", "TP53", "EGFR", "MYC", "KRAS", "BRAF", "PIK3CA", "PTEN",
         "RB1", "APC", "VHL", "WT1", "NF1", "RET", "ALK"]

# Control samples (3 replicates)
control = np.random.poisson(lam=100, size=(len(genes), 3))
# Treatment samples -- some genes upregulated, some down
treatment = np.random.poisson(lam=100, size=(len(genes), 3))
# Simulate differential expression
treatment[0] *= 3   # BRCA1 upregulated
treatment[1] *= 4   # TP53 upregulated
treatment[4] //= 3  # KRAS downregulated
treatment[7] //= 2  # PTEN downregulated

df = pd.DataFrame(
    np.hstack([control, treatment]),
    index=genes,
    columns=["ctrl_1", "ctrl_2", "ctrl_3", "treat_1", "treat_2", "treat_3"]
)

print("Gene expression count matrix:")
print(df)
print(f"\nShape: {df.shape[0]} genes x {df.shape[1]} samples")

# Calculate means
df["ctrl_mean"] = df[["ctrl_1", "ctrl_2", "ctrl_3"]].mean(axis=1)
df["treat_mean"] = df[["treat_1", "treat_2", "treat_3"]].mean(axis=1)
df["fold_change"] = df["treat_mean"] / df["ctrl_mean"]
df["log2_fc"] = np.log2(df["fold_change"].replace(0, np.nan))

print("\nDifferential expression summary:")
print("-" * 60)
summary = df[["ctrl_mean", "treat_mean", "fold_change", "log2_fc"]].round(2)
print(summary.sort_values("log2_fc", ascending=False))

# Classify
print("\nUpregulated (log2FC > 1):")
up = summary[summary["log2_fc"] > 1]
for gene in up.index:
    print(f"  {gene}: log2FC = {up.loc[gene, 'log2_fc']}")

print("\nDownregulated (log2FC < -1):")
down = summary[summary["log2_fc"] < -1]
for gene in down.index:
    print(f"  {gene}: log2FC = {down.loc[gene, 'log2_fc']}")
