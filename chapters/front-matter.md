# Bioinformatics with AI
## A Modern Introduction

**Dr. Cary Woods**

*Envoi Publishing*

---

## Copyright

Copyright (c) 2026 Cary Woods. All rights reserved.

Published by Envoi Publishing
Indianapolis, Indiana

ISBN: [See ISBN registration]

No part of this publication may be reproduced, distributed, or transmitted
in any form or by any means without the prior written permission of the
publisher, except for brief quotations in critical reviews and certain
other noncommercial uses permitted by copyright law.

---

## About This Book

This textbook teaches modern bioinformatics to college undergraduates --
freshmen and sophomores with no biology or programming prerequisites.

Every chapter teaches Python fundamentals through biological problems.
Every script has two versions: a vanilla version that teaches core concepts,
and an AI-assisted version that shows how large language models transform
the workflow.

By the end of this course, students will be able to:

- Read and analyze DNA, RNA, and protein sequences
- Navigate biological databases (NCBI, PDB, UniProt)
- Perform sequence alignment and BLAST searches
- Analyze gene expression data
- Understand protein structure prediction (AlphaFold)
- Use AI as a biological reasoning partner
- Build reproducible bioinformatics pipelines

---

## For Instructors

This book is designed for a one-semester introductory bioinformatics course.
The 14 chapters map to a 15-week semester (one chapter per week, with a
review week). Each chapter includes:

- Conceptual introduction (no prerequisites assumed)
- Working code examples (vanilla + AI versions)
- Hands-on laboratory exercises
- Discussion questions
- Suggested readings

All scripts are available at the book's GitHub repository.
The AI features require an OpenAI API key (or compatible provider),
but all vanilla scripts run without any API access.

Course adoption materials, including a sample syllabus and instructor
guide, are available from the publisher.

---

## Table of Contents

### Part I: Foundations

**Chapter 1: The Language of Life, The Language of Code**
- What is bioinformatics?
- Why Python? Why AI?
- Setting up your environment
- Your first program: Hello World with DNA
- The AI workflow: prompt, generate, test, understand

**Chapter 2: Python Basics Through Biology**
- Variables and types (DNA as strings)
- Lists and loops (iterating over nucleotides)
- Conditionals (is this a start codon?)
- Functions (wrap your nucleotide counter)
- File I/O (reading sequences from files)
- Dictionaries (codon table lookup)

**Chapter 3: The Central Dogma -- DNA to Protein**
- Biology crash course: DNA to RNA to protein
- The genetic code as a Python dictionary
- Transcription and translation
- Reading frames (3 forward, 3 reverse)
- Finding open reading frames
- BioPython's Seq object

**Chapter 4: Working with Real Biological Data**
- FASTA format
- GenBank format
- Parsing with BioPython (SeqIO)
- NCBI Entrez: searching and downloading
- Data quality and ambiguous nucleotides

### Part II: Analysis

**Chapter 5: Comparing Sequences -- Alignment and Similarity**
- Why compare sequences?
- Global and local alignment
- Scoring matrices (BLOSUM, PAM)
- BLAST: searching NCBI databases
- Interpreting results with AI

**Chapter 6: Sequence Patterns and Motifs**
- Regular expressions for biology
- Restriction enzyme mapping
- Motif finding and position weight matrices
- Command-line tools and argument parsing
- Debugging bioinformatics code

**Chapter 7: Gene Expression and RNA-seq**
- RNA-seq pipeline overview
- Count matrices with pandas
- Differential expression analysis
- Volcano plots and heatmaps
- Gene Ontology interpretation

**Chapter 8: Protein Structure and AlphaFold**
- Why structure matters
- PDB format and parsing
- AlphaFold: AI predicts structure
- Visualizing structures
- Structure-function relationships

### Part III: Modern Genomics

**Chapter 9: Genome Analysis**
- Genomes at scale
- Variant calling basics (SNPs, indels)
- VCF format and parsing
- Variant annotation
- Pharmacogenomics introduction

**Chapter 10: Metagenomics and the Microbiome**
- What is a microbiome?
- Taxonomic classification
- Diversity metrics
- Comparing communities
- Clinical applications

**Chapter 11: Single-Cell and Spatial Biology**
- Why single cells?
- Clustering and cell type annotation
- Spatial transcriptomics
- Marker gene identification
- Current technologies

### Part IV: AI-Native Bioinformatics

**Chapter 12: LLMs as Biological Reasoning Engines**
- Prompt engineering for biology
- Literature mining with AI
- Hypothesis generation
- Limitations and hallucinations
- Building Q&A pipelines

**Chapter 13: Building Bioinformatics Pipelines**
- Pipeline design principles
- Shell scripting basics
- Error handling and logging
- BLAST output parsing
- Reproducibility and containers

**Chapter 14: Capstone Projects**
- Variant-to-drug analysis
- Gene expression dashboard
- Designing your own analysis
- Presentation skills
- The future of bioinformatics

---

## Appendices

**Appendix A:** Python Quick Reference
**Appendix B:** BioPython Cheat Sheet
**Appendix C:** Linux/Command Line Essentials
**Appendix D:** The Perl Legacy (historical context)
**Appendix E:** Glossary of Biological Terms
**Appendix F:** API Keys and Environment Setup
