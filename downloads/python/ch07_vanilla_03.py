#!/usr/bin/env python3
"""
Chapter 7, Script 3 -- Vanilla Version
Gene Ontology: what do genes actually do?

Concept: GO terms, functional annotation, biological process
"""

# Simulated GO annotations for our differentially expressed genes
go_annotations = {
    "BRCA1": {
        "biological_process": ["DNA repair", "cell cycle checkpoint", "double-strand break repair"],
        "molecular_function": ["ubiquitin-protein ligase activity", "protein binding"],
        "cellular_component": ["nucleus", "BRCA1-A complex"]
    },
    "TP53": {
        "biological_process": ["apoptosis", "cell cycle arrest", "DNA damage response"],
        "molecular_function": ["DNA binding", "transcription factor activity"],
        "cellular_component": ["nucleus", "cytoplasm"]
    },
    "KRAS": {
        "biological_process": ["signal transduction", "cell proliferation", "MAPK cascade"],
        "molecular_function": ["GTPase activity", "protein binding"],
        "cellular_component": ["plasma membrane", "cytoplasm"]
    },
    "PTEN": {
        "biological_process": ["negative regulation of cell proliferation", "apoptosis"],
        "molecular_function": ["phosphatase activity", "phosphoprotein phosphatase activity"],
        "cellular_component": ["cytoplasm", "nucleus"]
    }
}

print("Gene Ontology annotations for key genes:")
print("=" * 60)

for gene, go in go_annotations.items():
    print(f"\n{gene}:")
    for aspect, terms in go.items():
        label = aspect.replace("_", " ").title()
        print(f"  {label}:")
        for term in terms:
            print(f"    - {term}")

# Find shared GO terms
print("\n\nShared biological processes:")
bp_sets = {}
for gene, go in go_annotations.items():
    for term in go["biological_process"]:
        bp_sets.setdefault(term, []).append(gene)

for term, genes in sorted(bp_sets.items(), key=lambda x: -len(x[1])):
    if len(genes) > 1:
        print(f"  {term}: {', '.join(genes)}")
