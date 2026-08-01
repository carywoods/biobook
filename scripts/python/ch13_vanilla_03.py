#!/usr/bin/env python3
"""
Chapter 13, Script 3 -- Vanilla Version
Building a complete bioinformatics pipeline.

Concept: pipeline design, subprocess, chaining steps, output
"""

import os
import tempfile


def run_step(name: str, func, *args, **kwargs):
    """Run a pipeline step with logging."""
    print(f"  [{name}] Starting...")
    try:
        result = func(*args, **kwargs)
        print(f"  [{name}] Complete")
        return result
    except Exception as e:
        print(f"  [{name}] FAILED: {e}")
        return None


def step1_read_sequences(input_file: str) -> list:
    """Read sequences from FASTA file."""
    sequences = {}
    current = None
    with open(input_file) as f:
        for line in f:
            line = line.strip()
            if line.startswith(">"):
                current = line[1:]
                sequences[current] = ""
            elif current:
                sequences[current] += line
    return sequences


def step2_filter_sequences(sequences: dict, min_length: int = 50) -> dict:
    """Filter sequences by minimum length."""
    return {k: v for k, v in sequences.items() if len(v) >= min_length}


def step3_compute_stats(sequences: dict) -> dict:
    """Compute basic statistics."""
    lengths = [len(v) for v in sequences.values()]
    gc_counts = [v.count("G") + v.count("C") for v in sequences.values()]
    return {
        "count": len(sequences),
        "total_bases": sum(lengths),
        "mean_length": sum(lengths) / len(lengths) if lengths else 0,
        "gc_content": sum(gc_counts) / sum(lengths) * 100 if lengths else 0,
    }


def step4_write_output(sequences: dict, output_file: str) -> int:
    """Write filtered sequences to output file."""
    with open(output_file, "w") as f:
        for header, seq in sequences.items():
            f.write(f">{header}\n")
            for i in range(0, len(seq), 60):
                f.write(seq[i:i+60] + "\n")
    return len(sequences)


# --- Main program ---
# Create sample input
sample = ">seq1\nATGGTGCATCTGACTCCTGAGGAGAAGTCTGCCGTTACTGCCCTGTGGGGCAAGGTGAAC\n>short\nATCG\n>seq2\nGTGGATGAAGTTGGTGGTGAGGCCCTGGGCAGGCTGCTGGTGGTCTACCCTTGGACCCAG\n"

input_file = os.path.join(tempfile.gettempdir(), "pipeline_input.fasta")
output_file = os.path.join(tempfile.gettempdir(), "pipeline_output.fasta")

with open(input_file, "w") as f:
    f.write(sample)

print("Bioinformatics Pipeline")
print("=" * 40)
print(f"Input: {input_file}\n")

# Run pipeline
sequences = run_step("Read", step1_read_sequences, input_file)
if sequences:
    filtered = run_step("Filter", step2_filter_sequences, sequences, min_length=50)
    if filtered:
        stats = run_step("Stats", step3_compute_stats, filtered)
        count = run_step("Write", step4_write_output, filtered, output_file)

        print(f"\nPipeline Results:")
        print(f"  Input sequences: {len(sequences)}")
        print(f"  After filtering: {stats['count']}")
        print(f"  Total bases: {stats['total_bases']}")
        print(f"  Mean length: {stats['mean_length']:.0f}")
        print(f"  GC content: {stats['gc_content']:.1f}%")
        print(f"  Output: {output_file}")

# Cleanup
os.remove(input_file)
if os.path.exists(output_file):
    os.remove(output_file)
