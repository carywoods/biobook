#!/usr/bin/env python3
"""
Chapter 13, Script 2 -- Vanilla Version
File I/O with error handling: robust bioinformatics scripts.

Translated from: example5-6.pl
Concept: try/except, file validation, error messages, defensive programming
"""

import os
import sys


def read_sequence_file(filename: str) -> str:
    """Read a sequence file with proper error handling."""
    # Check if file exists
    if not os.path.exists(filename):
        raise FileNotFoundError(f"File not found: {filename}")

    # Check if it's actually a file
    if not os.path.isfile(filename):
        raise IsADirectoryError(f"Not a file: {filename}")

    # Check if readable
    if not os.access(filename, os.R_OK):
        raise PermissionError(f"Cannot read: {filename}")

    # Check file size
    size = os.path.getsize(filename)
    if size == 0:
        raise ValueError(f"File is empty: {filename}")
    if size > 1_000_000:  # 1MB
        print(f"Warning: large file ({size:,} bytes)")

    # Read the file
    with open(filename) as f:
        content = f.read().strip()

    return content


def validate_dna(sequence: str) -> tuple:
    """Validate a DNA sequence. Returns (is_valid, errors)."""
    errors = []
    valid_bases = set("ATCGatcg")

    invalid = set(sequence) - valid_bases
    if invalid:
        errors.append(f"Invalid characters: {invalid}")

    if len(sequence) < 10:
        errors.append(f"Sequence too short ({len(sequence)} bases)")

    return (len(errors) == 0, errors)


# --- Main program ---
test_files = ["test.dna", "/tmp/sample.dna", "/etc/passwd"]

for filename in test_files:
    print(f"\nTrying to read: {filename}")
    try:
        content = read_sequence_file(filename)
        print(f"  Read {len(content)} characters")

        is_valid, errors = validate_dna(content)
        if is_valid:
            print(f"  Valid DNA sequence")
        else:
            print(f"  Validation errors: {errors}")

    except FileNotFoundError as e:
        print(f"  Error: {e}")
    except PermissionError as e:
        print(f"  Error: {e}")
    except ValueError as e:
        print(f"  Error: {e}")
    except Exception as e:
        print(f"  Unexpected error: {type(e).__name__}: {e}")
