#!/usr/bin/env python3
"""
Chapter 1, Script 2 -- Vanilla Version
Setting up your bioinformatics toolkit.

Concept: Python environment, installing packages, verifying setup
"""

import sys
import subprocess


def check_package(name: str) -> bool:
    """Check if a Python package is installed."""
    try:
        __import__(name)
        return True
    except ImportError:
        return False


def check_command(command: str) -> bool:
    """Check if a system command is available."""
    try:
        subprocess.run([command, "--version"], capture_output=True, timeout=5)
        return True
    except (FileNotFoundError, subprocess.TimeoutExpired):
        return False


# --- Main program ---
print("Bioinformatics Toolkit Setup Check")
print("=" * 40)

# Python version
print(f"\nPython: {sys.version.split()[0]}")
if sys.version_info >= (3, 8):
    print("  Status: OK")
else:
    print("  WARNING: Python 3.8+ recommended")

# Core packages
packages = {
    "biopython": "BioPython (sequence analysis)",
    "pandas": "pandas (data tables)",
    "numpy": "numpy (numerical computing)",
    "matplotlib": "matplotlib (plotting)",
}

print("\nPython packages:")
for pkg, description in packages.items():
    installed = check_package(pkg.replace("biopython", "Bio").replace("matplotlib", "matplotlib"))
    status = "INSTALLED" if installed else "MISSING"
    print(f"  {description:35s} [{status}]")

# Optional AI package
print("\nOptional (AI features):")
ai_installed = check_package("openai")
print(f"  {'openai (LLM integration)':35s} [{'INSTALLED' if ai_installed else 'MISSING'}]")

print("\nTo install missing packages:")
print("  pip install biopython pandas numpy matplotlib openai")
