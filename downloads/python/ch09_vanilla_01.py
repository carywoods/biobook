#!/usr/bin/env python3
"""
Chapter 9, Script 1 -- Vanilla Version
Variant calling basics: reading VCF files.

Concept: VCF format, SNPs, indels, variant annotation
"""

# Sample VCF data (simplified)
vcf_data = """\
##fileformat=VCFv4.2
##source=sample
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO
chr1	11856378	rs123456	G	A	99	PASS	DP=50;AF=0.45
chr1	11856424	rs789012	T	C	85	PASS	DP=42;AF=0.38
chr7	55191822	rs1212127	T	G	95	PASS	DP=67;AF=0.52
chr17	41245466	rs80357906	A	G	99	PASS	DP=55;AF=0.01
chr12	25398284	rs121913529	C	T	99	PASS	DP=48;AF=0.02
"""

# Parse VCF
print("Parsing VCF file:\n")
print(f"{'CHROM':8s} {'POS':>10s} {'ID':>12s} {'REF':>4s} {'ALT':>4s} {'QUAL':>5s} {'AF':>6s}")
print("-" * 55)

variants = []
for line in vcf_data.strip().split("\n"):
    if line.startswith("#"):
        continue
    fields = line.split("\t")
    chrom, pos, vid, ref, alt, qual, filt, info = fields
    # Extract allele frequency
    af = 0.0
    for item in info.split(";"):
        if item.startswith("AF="):
            af = float(item.split("=")[1])
    variants.append({"chrom": chrom, "pos": int(pos), "id": vid, "ref": ref, "alt": alt, "qual": int(qual), "af": af})
    print(f"{chrom:8s} {pos:>10s} {vid:>12s} {ref:>4s} {alt:>4s} {qual:>5s} {af:>6.2f}")

# Classify variants
print(f"\nTotal variants: {len(variants)}")

snps = [v for v in variants if len(v["ref"]) == 1 and len(v["alt"]) == 1]
indels = [v for v in variants if len(v["ref"]) != len(v["alt"])]
print(f"SNPs: {len(snps)}")
print(f"Indels: {len(indels)}")

# Common vs rare
common = [v for v in variants if v["af"] > 0.05]
rare = [v for v in variants if v["af"] <= 0.05]
print(f"\nCommon (AF > 5%): {len(common)}")
for v in common:
    print(f"  {v['id']}: {v['ref']}>{v['alt']} AF={v['af']:.2f}")
print(f"Rare (AF <= 5%): {len(rare)}")
for v in rare:
    print(f"  {v['id']}: {v['ref']}>{v['alt']} AF={v['af']:.2f}")
