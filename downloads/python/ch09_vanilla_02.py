#!/usr/bin/env python3
"""
Chapter 9, Script 2 -- Vanilla Version
Variant annotation: predicting the effect of mutations.

Concept: codon tables, missense/nonsense/synonymous mutations
"""

CODON_TABLE = {
    "TTT": "F", "TTC": "F", "TTA": "L", "TTG": "L", "CTT": "L", "CTC": "L", "CTA": "L", "CTG": "L",
    "ATT": "I", "ATC": "I", "ATA": "I", "ATG": "M", "GTT": "V", "GTC": "V", "GTA": "V", "GTG": "V",
    "TCT": "S", "TCC": "S", "TCA": "S", "TCG": "S", "CCT": "P", "CCC": "P", "CCA": "P", "CCG": "P",
    "ACT": "T", "ACC": "T", "ACA": "T", "ACG": "T", "GCT": "A", "GCC": "A", "GCA": "A", "GCG": "A",
    "TAT": "Y", "TAC": "Y", "TAA": "*", "TAG": "*", "CAT": "H", "CAC": "H", "CAA": "Q", "CAG": "Q",
    "AAT": "N", "AAC": "N", "AAA": "K", "AAG": "K", "GAT": "D", "GAC": "D", "GAA": "E", "GAG": "E",
    "TGT": "C", "TGC": "C", "TGA": "*", "TGG": "W", "CGT": "R", "CGC": "R", "CGA": "R", "CGG": "R",
    "AGT": "S", "AGC": "S", "AGA": "R", "AGG": "R", "GGT": "G", "GGC": "G", "GGA": "G", "GGG": "G",
}


def annotate_variant(codon: str, position: int, new_base: str) -> str:
    """Predict the effect of a single-base change in a codon."""
    ref_aa = CODON_TABLE.get(codon, "?")
    mutated_codon = codon[:position] + new_base + codon[position + 1:]
    alt_aa = CODON_TABLE.get(mutated_codon, "?")

    if ref_aa == alt_aa:
        return "synonymous"
    elif alt_aa == "*":
        return "nonsense (stop gain)"
    elif ref_aa == "*":
        return "stop loss"
    else:
        return "missense"


# Known pathogenic variants
variants = [
    {"gene": "BRAF", "codon": "GTG", "pos": 0, "alt": "T", "note": "V600E -- most common BRAF mutation in cancer"},
    {"gene": "KRAS", "codon": "GGT", "pos": 1, "alt": "A", "note": "G12D -- common in pancreatic cancer"},
    {"gene": "HBB", "codon": "GAG", "pos": 1, "alt": "T", "note": "E6V -- causes sickle cell disease"},
]

print("Variant annotation:")
print("=" * 60)
for v in variants:
    ref_aa = CODON_TABLE.get(v["codon"], "?")
    effect = annotate_variant(v["codon"], v["pos"], v["alt"])
    mut_codon = v["codon"][:v["pos"]] + v["alt"] + v["codon"][v["pos"] + 1:]
    alt_aa = CODON_TABLE.get(mut_codon, "?")
    print(f"\n  {v['gene']}: {v['codon']}({ref_aa}) -> {mut_codon}({alt_aa})")
    print(f"  Effect: {effect}")
    print(f"  Note: {v['note']}")
