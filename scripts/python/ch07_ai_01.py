#!/usr/bin/env python3
"""
Chapter 7, Script 1 -- AI Version
RNA-seq analysis + AI interprets the differentially expressed genes.
"""

import os
import pandas as pd
import numpy as np

try:
    from openai import OpenAI
    client = OpenAI(api_key=os.environ.get("OPENAI_API_KEY", ""), base_url=os.environ.get("OPENAI_BASE_URL", "https://openrouter.ai/api/v1"))
    AI_AVAILABLE = True
except ImportError:
    AI_AVAILABLE = False
    print("Note: Install openai package for AI features\n")

def ask_ai(prompt: str) -> str:
    if not AI_AVAILABLE:
        return "(AI not available)"
    return client.chat.completions.create(model=os.environ.get("OPENAI_MODEL", "google/gemini-2.5-flash"), messages=[{"role": "user", "content": prompt}], temperature=0.3).choices[0].message.content

np.random.seed(42)
genes = ["BRCA1", "TP53", "EGFR", "MYC", "KRAS", "BRAF", "PIK3CA", "PTEN", "RB1", "APC"]
control = np.random.poisson(lam=100, size=(len(genes), 3))
treatment = np.random.poisson(lam=100, size=(len(genes), 3))
treatment[0] *= 3; treatment[1] *= 4; treatment[4] //= 3; treatment[7] //= 2

df = pd.DataFrame(np.hstack([control, treatment]), index=genes, columns=["c1","c2","c3","t1","t2","t3"])
df["ctrl_mean"] = df[["c1","c2","c3"]].mean(axis=1)
df["treat_mean"] = df[["t1","t2","t3"]].mean(axis=1)
df["log2_fc"] = np.log2((df["treat_mean"] / df["ctrl_mean"]).replace(0, np.nan))

print("Differential expression results:")
for gene in df.sort_values("log2_fc", ascending=False).index:
    fc = df.loc[gene, "log2_fc"]
    direction = "UP" if fc > 1 else ("DOWN" if fc < -1 else "---")
    print(f"  {gene:8s} log2FC={fc:+.2f}  {direction}")

up_genes = df[df["log2_fc"] > 1].index.tolist()
down_genes = df[df["log2_fc"] < -1].index.tolist()

print(f"\n--- AI: What do these expression changes mean? ---\n")
result = ask_ai(
    f"In a cancer treatment experiment, these genes changed expression:\n\n"
    f"Upregulated: {up_genes}\n"
    f"Downregulated: {down_genes}\n\n"
    "Please explain:\n"
    "1. What does each gene do? (BRCA1, TP53, KRAS, PTEN)\n"
    "2. Is it good or bad that TP53 is upregulated in a cancer context?\n"
    "3. What pathway might be affected?\n"
    "4. What experiment would you do next to confirm these results?\n\n"
    "Explain for a college student who knows basic biology but not cancer biology."
)
print(result)
