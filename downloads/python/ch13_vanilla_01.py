#!/usr/bin/env python3
"""
Chapter 13, Script 1 -- Vanilla Version
Parsing BLAST output.

Translated from: example12-1.pl and example12-2.pl
Concept: BLAST format, structured output parsing, sequence alignment
"""

# Simulated BLAST output (tabular format)
BLAST_OUTPUT = """\
# BLASTN 2.12.0+
# Query: query_sequence
# Database: nr
# Fields: query_id, subject_id, %identity, alignment_length, mismatches, gap_opens, q_start, q_end, s_start, s_end, evalue, bit_score
query_seq  NM_007294.4  99.85  675  1  0  1  675  1  675  0.0  1241
query_seq  NM_007294.3  99.70  675  2  0  1  675  1  675  0.0  1237
query_seq  XM_006710328.4  98.22  675  12  0  1  675  1  675  0.0  1204
query_seq  NM_001354609.2  97.48  675  17  0  1  675  1  675  0.0  1189
query_seq  XM_017003169.3  95.56  675  30  0  1  675  1  675  0.0  1144
"""


def parse_blast_tabular(output: str) -> list:
    """Parse BLAST tabular output."""
    results = []
    for line in output.strip().split("\n"):
        if line.startswith("#"):
            continue
        fields = line.split()
        if len(fields) >= 12:
            results.append({
                "query": fields[0].strip(),
                "subject": fields[1].strip(),
                "identity": float(fields[2]),
                "alignment_length": int(fields[3]),
                "mismatches": int(fields[4]),
                "evalue": float(fields[10]),
                "bit_score": float(fields[11]),
            })
    return results


# --- Main program ---
results = parse_blast_tabular(BLAST_OUTPUT)

print(f"BLAST results: {len(results)} hits\n")
print(f"{'Subject':25s} {'%ID':>6s} {'Length':>6s} {'Mis':>4s} {'E-value':>10s} {'Score':>7s}")
print("-" * 65)

for r in results:
    print(f"{r['subject']:25s} {r['identity']:6.1f} {r['alignment_length']:6d} "
          f"{r['mismatches']:4d} {r['evalue']:10.1e} {r['bit_score']:7.0f}")

# Analysis
print(f"\nSummary:")
print(f"  Best hit: {results[0]['subject']} ({results[0]['identity']}% identity)")
print(f"  All hits have E-value = 0.0 (extremely significant)")
print(f"  Identity range: {min(r['identity'] for r in results):.1f}% - {max(r['identity'] for r in results):.1f}%")
