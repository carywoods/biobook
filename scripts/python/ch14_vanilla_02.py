#!/usr/bin/env python3
"""
Chapter 14, Script 2 -- Vanilla Version
Capstone: Build a gene expression analysis dashboard.

Concept: integrating pandas, matplotlib, and data analysis into a complete workflow
"""

import numpy as np

# Simulated gene expression experiment
# Comparing cancer tissue vs normal tissue
np.random.seed(42)

# Gene names and their expected behavior
genes_info = {
    "TP53": {"normal": 100, "cancer": 30, "role": "tumor suppressor"},
    "MYC": {"normal": 50, "cancer": 200, "role": "oncogene"},
    "BRCA1": {"normal": 80, "cancer": 20, "role": "DNA repair"},
    "VEGFA": {"normal": 30, "cancer": 150, "role": "angiogenesis"},
    "CDH1": {"normal": 120, "cancer": 40, "role": "cell adhesion"},
    "KRAS": {"normal": 60, "cancer": 180, "role": "signal transduction"},
    "PTEN": {"normal": 90, "cancer": 25, "role": "tumor suppressor"},
    "EGFR": {"normal": 40, "cancer": 160, "role": "growth factor receptor"},
}

# Generate expression data with noise
n_replicates = 3
print("Gene Expression Analysis: Cancer vs Normal Tissue")
print("=" * 60)
print(f"\n{'Gene':8s} {'Role':20s} {'Normal':>10s} {'Cancer':>10s} {'log2FC':>8s} {'Status':>10s}")
print("-" * 70)

results = []
for gene, info in genes_info.items():
    normal_expr = np.random.poisson(info["normal"], n_replicates)
    cancer_expr = np.random.poisson(info["cancer"], n_replicates)

    normal_mean = normal_expr.mean()
    cancer_mean = cancer_expr.mean()
    log2fc = np.log2(cancer_mean / normal_mean) if normal_mean > 0 else 0

    status = "UP" if log2fc > 1 else ("DOWN" if log2fc < -1 else "NS")
    results.append((gene, info["role"], normal_mean, cancer_mean, log2fc, status))
    print(f"{gene:8s} {info['role']:20s} {normal_mean:10.1f} {cancer_mean:10.1f} {log2fc:+8.2f} {status:>10s}")

# Summary
upregulated = [r for r in results if r[5] == "UP"]
downregulated = [r for r in results if r[5] == "DOWN"]

print(f"\nSummary:")
print(f"  Total genes: {len(results)}")
print(f"  Upregulated in cancer: {len(upregulated)} -- {', '.join(r[0] for r in upregulated)}")
print(f"  Downregulated in cancer: {len(downregulated)} -- {', '.join(r[0] for r in downregulated)}")

print(f"\nBiological interpretation:")
print(f"  Oncogenes activated: {', '.join(r[0] for r in upregulated if 'oncogene' in r[1] or 'growth' in r[1] or 'angiogenesis' in r[1] or 'signal' in r[1])}")
print(f"  Tumor suppressors lost: {', '.join(r[0] for r in downregulated if 'tumor' in r[1] or 'repair' in r[1] or 'adhesion' in r[1])}")
