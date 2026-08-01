# Bioinformatics with AI -- Script Selection
# 50 scripts selected from 49 companion + extracted sources
# Mapped to 14 textbook chapters

## Selection Criteria
- Runs independently or with minimal sample data
- Teaches a clear, standalone concept
- Good size for textbook examples (15-90 lines)
- Maps naturally to Python equivalent
- Covers core bioinformatics operations

---

## CHAPTER 1: The Language of Life, The Language of Code
(No Perl scripts -- this chapter uses Python from scratch)

---

## CHAPTER 2: Python Basics Through Biology

| # | Script | Lines | Concept | Perl -> Python |
|---|--------|-------|---------|----------------|
| 1 | example4-1.pl | 11 | Store and print DNA | string variable, print() |
| 2 | example4-2.pl | 36 | Concatenate DNA fragments | string operations, variables |
| 3 | example4-8.pl | 16 | Scalar vs list context | len(), indexing (Perl-specific, adapt to Python basics) |
| 4 | example5-1.pl | 28 | Conditionals (if/elsif/else) | if/elif/else with strings |
| 5 | example5-5.pl | 21 | Arrays and iteration | lists, for loops |

**Python equivalents:** 5 scripts -> 5 short Python exercises
**Key teaching:** variables, strings, lists, loops, conditionals through DNA

---

## CHAPTER 3: The Central Dogma -- DNA to Protein

| # | Script | Lines | Concept | Perl -> Python |
|---|--------|-------|---------|----------------|
| 6 | example6-1.pl | 26 | Subroutine: append to DNA | functions, return values |
| 7 | example6-2.pl | 23 | Substitution with regex | str.replace() or re.sub() |
| 8 | example8-1.pl | 21 | Translate codons to protein | codon table dict, Bio.Seq |
| 9 | example8-2.pl | 21 | Extract DNA from FASTA | file reading, parsing |
| 10 | example8-3.pl | 26 | FASTA -> translate -> print | full pipeline |
| 11 | example8-4.pl | 49 | Six reading frames | rev comp + 3 frames each |

**Python equivalents:** Bio.Seq.translate(), Bio.Seq.reverse_complement()
**Key teaching:** the central dogma in code, reading frames, BioPython basics

---

## CHAPTER 4: Working with Real Biological Data

| # | Script | Lines | Concept | Perl -> Python |
|---|--------|-------|---------|----------------|
| 12 | example10-1.pl | 65 | Parse GenBank annotation | Bio.SeqIO.read() |
| 13 | example10-2.pl | 37 | Extract annotation vs sequence | record.features, record.seq |
| 14 | example10-5.pl | 136 | GenBank library subroutines | SeqIO index, batch parsing |
| 15 | example12-4.pl | 25 | Create FASTA output | Bio.SeqIO.write() |

**Python equivalents:** Bio.SeqIO.parse(), Entrez.efetch()
**Key teaching:** real file formats, NCBI API access, structured data

---

## CHAPTER 5: Comparing Sequences -- Alignment and Similarity

| # | Script | Lines | Concept | Perl -> Python |
|---|--------|-------|---------|----------------|
| 16 | example7-2.pl | 130 | Mutate DNA randomly | random module, mutation model |
| 17 | example7-3.pl | 161 | Generate random DNA sets | random sequences, statistics |
| 18 | example7-4.pl | 189 | Compare random sequences (similarity) | pairwise comparison, % identity |
| 19 | example5-4.pl | 78 | Nucleotide frequency counting | collections.Counter |
| 20 | example5-3.pl | 63 | Motif searching in protein | re.finditer(), pattern matching |

**Python equivalents:** Bio.pairwise2, subprocess.run("blastn")
**Key teaching:** similarity as a concept, random simulation, counting

---

## CHAPTER 6: Sequence Patterns and Motifs

| # | Script | Lines | Concept | Perl -> Python |
|---|--------|-------|---------|----------------|
| 21 | example9-2.pl | 55 | Parse restriction enzyme database | dict parsing, file formats |
| 22 | example9-3.pl | 98 | Build restriction map | regex on DNA, enzyme mapping |
| 23 | example6-3.pl | 51 | Count specific bases (CLI args) | sys.argv, argparse |
| 24 | example6-4.pl | 56 | Debugging exercise (bugs in code) | find and fix errors |

**Python equivalents:** re.finditer() for enzyme sites, Biopython.Restriction
**Key teaching:** regex for biology, restriction enzymes, debugging

---

## CHAPTER 7: Gene Expression and RNA-seq
(No direct Perl equivalents -- new chapter)
**Use:** pandas DataFrames, DESeq2 concepts, matplotlib volcano plots

---

## CHAPTER 8: Protein Structure and AlphaFold

| # | Script | Lines | Concept | Perl -> Python |
|---|--------|-------|---------|----------------|
| 25 | example11-1.pl | 26 | Open directory, list files | os.listdir(), pathlib |
| 26 | example11-2.pl | 56 | Navigate folder tree recursively | os.walk() |
| 27 | example11-5.pl | 163 | Parse PDB file (SEQRES chains) | Bio.PDB parser |
| 28 | example11-7.pl | 92 | Extract PDB sequence data | structure.chain extraction |

**Python equivalents:** Bio.PDB, py3Dmol, requests.get(alphafold API)
**Key teaching:** file system navigation, PDB format, structure data

---

## CHAPTER 9: Genome Analysis
(No direct Perl equivalents -- new chapter)
**Use:** pysam, cyvcf2, variant annotation pipelines

---

## CHAPTER 10: Metagenomics and the Microbiome
(No direct Perl equivalents -- new chapter)
**Use:** Kraken2, MetaPhlAn, pandas diversity metrics

---

## CHAPTER 11: Single-Cell and Spatial Biology
(No direct Perl equivalents -- new chapter)
**Use:** scanpy, AnnData, UMAP/clustering

---

## CHAPTER 12: LLMs as Biological Reasoning Engines
(No direct Perl equivalents -- new chapter)
**Use:** openai/anthropic API, prompt templates, RAG over PubMed

---

## CHAPTER 13: Building Bioinformatics Pipelines

| # | Script | Lines | Concept | Perl -> Python |
|---|--------|-------|---------|----------------|
| 29 | example12-1.pl | 93 | Parse BLAST output | subprocess + parsing |
| 30 | example12-2.pl | 110 | BLAST alignment extraction | structured output parsing |
| 31 | example5-6.pl | 75 | File I/O with error handling | try/except, pathlib |

**Python equivalents:** subprocess, snakemake, argparse
**Key teaching:** pipeline construction, error handling, tool integration

---

## CHAPTER 14: Capstone Projects
(Uses concepts from all previous scripts)

---

## TOTAL: 31 Perl source scripts -> ~31 Python equivalents

### Scripts NOT selected (and why):
- example4-3.pl, 4-4.pl, 4-5.pl, 4-6.pl, 4-7.pl -- redundant with 4-1, 4-2
- example5-2.pl, 5-7.pl -- file I/O variants, covered by others
- example7-1.pl -- interactive (stdin), hard to use in textbook
- example9-1.pl -- produces no output
- example10-3.pl, 10-4.pl, 10-6.pl, 10-7.pl, 10-8.pl -- GenBank variants, 10-1/10-2/10-5 cover the concepts
- example11-3.pl, 11-4.pl, 11-6.pl -- PDB variants, 11-2/11-5/11-7 cover the concepts
- example12-3.pl -- trivial loop demo

### Additional Python-only scripts needed (no Perl equivalent):
- Chapter 7: RNA-seq count matrix analysis (3 scripts)
- Chapter 9: VCF variant parsing (2 scripts)
- Chapter 10: 16S taxonomy classification (2 scripts)
- Chapter 11: Single-cell clustering with scanpy (2 scripts)
- Chapter 12: LLM prompt for gene interpretation (2 scripts)

**Grand total: 31 Perl-derived + 11 Python-native = 42 scripts for the textbook**
