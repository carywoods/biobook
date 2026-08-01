# Bioinformatics Book

**Type:** Publishing / Bioinformatics / Education
**Status:** ACTIVE -- Textbook outline complete, source scripts extracted
**Parent:** Publishing

## Overview

Write an undergraduate textbook (freshmen/sophomores, non-biology majors) teaching modern bioinformatics using Python and AI. Three classic Perl bioinformatics texts serve as pedagogical foundation.

## Target Audience

- College freshmen and sophomores
- No biology prerequisites
- No programming experience assumed
- Interested in learning bioinformatics through AI-assisted coding

## Title (Working)

"Bioinformatics with AI: A Modern Introduction"

## Source Books

1. **Beginning Perl for Bioinformatics** -- James Tisdall (O'Reilly)
   - Companion repo: github.com/M-Mono/Beginning-Perl-for-Bioinformatics
   - 49 scripts + BeginPerlBioinfo.pm module (all compile and run)
2. **Mastering Perl for Bioinformatics** -- James Tisdall (O'Reilly)
   - PDF extraction v2: 425 code snippets, 91 compile (mostly fragments)
3. **Bioinformatics, Biocomputing and Perl** -- Moorhouse & Barry (Wiley 2004)
   - PDF extraction v2: 52 blocks, 0 compile (monospace prose issue)

## Chapter Structure (14 chapters)

### Part I: Foundations (1-4)
1. The Language of Life, The Language of Code
2. Python Basics Through Biology
3. The Central Dogma -- DNA to Protein
4. Working with Real Biological Data

### Part II: Analysis (5-8)
5. Comparing Sequences -- Alignment and Similarity
6. Sequence Patterns and Motifs
7. Gene Expression and RNA-seq
8. Protein Structure and AlphaFold

### Part III: Modern Genomics (9-11)
9. Genome Analysis
10. Metagenomics and the Microbiome
11. Single-Cell and Spatial Biology

### Part IV: AI-Native Bioinformatics (12-14)
12. LLMs as Biological Reasoning Engines
13. Building Bioinformatics Pipelines
14. Capstone Projects

## File Locations

- Textbook outline: `textbook-outline.md`
- Companion scripts (49, all working): `scripts/companion/`
- Perl utility module: `scripts/companion/BeginPerlBioinfo.pm`
- Mastering Perl v2 snippets: `scripts/extracted_v2/`
- Original PDFs: `pdfs/`
- Extraction tools: `scripts/extract_perl_scripts.py`, `scripts/extract_v2.py`, `scripts/clean_scripts.py`, `scripts/clean_phase2.py`

## CPAN Modules Installed

DBI, Bio::Perl, CGI, GD, GD::Graph, WWW::Mechanize, Statistics::ChiSquare

## Next Steps

- [x] Source code locations identified
- [x] Companion scripts found and verified (49 from Beginning Perl)
- [x] Textbook outline (14 chapters)
- [ ] Sample chapter (Chapter 3: Central Dogma)
- [ ] Chapter stubs for remaining chapters
- [ ] Python translation of all 49 Perl scripts
- [ ] AI integration patterns defined
- [ ] Publisher proposal / course adoption materials
