# Bioinformatics with AI: A Modern Introduction

**Dr. Cary Woods** | Envoi Publishing

A textbook teaching modern bioinformatics to college undergraduates using Python and AI.

## Quick Start

```bash
# Install dependencies
pip install biopython pandas numpy matplotlib openai

# Set up AI (optional -- get free key at aistudio.google.com)
export OPENAI_API_KEY="your-key"
export OPENAI_BASE_URL="https://generativelanguage.googleapis.com/v1beta/openai"
export OPENAI_MODEL="gemini-2.5-flash"

# Run a script
cd scripts/python
python ch01_vanilla_01.py
```

## Structure

```
bioinformatics-book/
├── README.md                    # This file
├── front-matter.md              # Title, copyright, preface, TOC
├── requirements.txt             # Python dependencies
├── project.md                   # Project status and metadata
│
├── chapters/                    # Chapter prose (markdown)
│   └── chapter01.md             # Chapter 1: The Language of Life
│
├── scripts/
│   ├── python/                  # 78 Python scripts (39 vanilla + 39 AI)
│   │   ├── ch01_vanilla_01.py   # Chapter 1, Script 1, vanilla
│   │   ├── ch01_ai_01.py        # Chapter 1, Script 1, AI-assisted
│   │   └── ...
│   └── perl/                    # Legacy Perl scripts (historical reference)
│       ├── companion/           # 49 companion scripts + BeginPerlBioinfo.pm
│       └── extracted/           # Scripts extracted from PDFs
│
├── appendices/                  # Supplementary materials
│   ├── appendix-f-setup.md      # API keys and environment setup
│   ├── textbook-outline.md      # Full chapter outline
│   └── script-selection.md      # Perl-to-Python script mapping
│
├── data/                        # Sample data files
│   └── sample.dna               # Sample DNA sequences
│
├── figures/                     # Generated figures (volcano plots, etc.)
│
└── pdfs/                        # Source PDFs (reference only)
```

## Chapters

| Chapter | Title | Vanilla | AI |
|---------|-------|---------|-----|
| 1 | The Language of Life, The Language of Code | 3 | 3 |
| 2 | Python Basics Through Biology | 4 | 4 |
| 3 | The Central Dogma -- DNA to Protein | 4 | 4 |
| 4 | Working with Real Biological Data | 3 | 3 |
| 5 | Comparing Sequences -- Alignment and Similarity | 4 | 4 |
| 6 | Sequence Patterns and Motifs | 3 | 3 |
| 7 | Gene Expression and RNA-seq | 3 | 3 |
| 8 | Protein Structure and AlphaFold | 2 | 2 |
| 9 | Genome Analysis | 2 | 2 |
| 10 | Metagenomics and the Microbiome | 2 | 2 |
| 11 | Single-Cell and Spatial Biology | 2 | 2 |
| 12 | LLMs as Biological Reasoning Engines | 2 | 2 |
| 13 | Building Bioinformatics Pipelines | 3 | 3 |
| 14 | Capstone Projects | 2 | 2 |
| **Total** | | **39** | **39** |

## How Scripts Work

Every script comes in two versions:

- **Vanilla** (`ch01_vanilla_01.py`): Standard Python/BioPython. No AI dependency. Teaches the fundamentals.
- **AI** (`ch01_ai_01.py`): Same core logic + LLM calls for interpretation. Requires an API key.

Students learn the vanilla version first, then see how AI enhances the workflow.

## AI Setup

See [Appendix F](appendices/appendix-f-setup.md) for full setup instructions.

**Free options:**
- Google Gemini (recommended): [aistudio.google.com](https://aistudio.google.com/)
- Groq (backup): [console.groq.com](https://console.groq.com/)

All AI scripts work without an API key (they skip the AI portion).

## License

Copyright (c) 2026 Cary Woods. All rights reserved.
Published by Envoi Publishing, Indianapolis, Indiana.
