#!/usr/bin/env python3
"""
Chapter 12, Script 2 -- Vanilla Version
Building a biological Q&A system using structured data.

Concept: knowledge bases, structured queries, data integration
"""

# A simple biological knowledge base
KNOWLEDGE_BASE = {
    "BRCA1": {
        "full_name": "Breast Cancer 1",
        "function": "DNA repair, tumor suppression",
        "chromosome": "17q21.31",
        "associated_diseases": ["breast cancer", "ovarian cancer"],
        "drugs": ["Olaparib (PARP inhibitor)", "Cisplatin"],
        "pathway": "Homologous recombination repair"
    },
    "TP53": {
        "full_name": "Tumor Protein p53",
        "function": "Cell cycle regulation, apoptosis",
        "chromosome": "17p13.1",
        "associated_diseases": ["Li-Fraumeni syndrome", "many cancers"],
        "drugs": ["APR-246 (experimental)"],
        "pathway": "p53 signaling pathway"
    },
    "KRAS": {
        "full_name": "Kirsten Rat Sarcoma Viral Oncogene",
        "function": "Signal transduction, cell growth",
        "chromosome": "12p12.1",
        "associated_diseases": ["lung cancer", "pancreatic cancer", "colorectal cancer"],
        "drugs": ["Sotorasib (KRAS G12C inhibitor)"],
        "pathway": "MAPK/ERK signaling pathway"
    }
}


def query_gene(gene: str) -> dict:
    """Look up a gene in the knowledge base."""
    return KNOWLEDGE_BASE.get(gene.upper(), None)


# --- Main program ---
print("Biological Knowledge Base")
print("=" * 40)
print(f"Available genes: {', '.join(KNOWLEDGE_BASE.keys())}\n")

# Query each gene
for gene in KNOWLEDGE_BASE:
    info = query_gene(gene)
    print(f"\n{gene} ({info['full_name']}):")
    print(f"  Function: {info['function']}")
    print(f"  Chromosome: {info['chromosome']}")
    print(f"  Diseases: {', '.join(info['associated_diseases'])}")
    print(f"  Drugs: {', '.join(info['drugs'])}")
    print(f"  Pathway: {info['pathway']}")

# Integration example
print("\n\nDrug-gene interactions:")
for gene, info in KNOWLEDGE_BASE.items():
    for drug in info["drugs"]:
        print(f"  {drug} targets {gene} ({info['pathway']})")
