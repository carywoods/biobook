# Bioinformatics with AI: A Modern Introduction
## Chapter Outline for College Undergraduates (Freshmen/Sophomores)
## Target: Non-biology majors, no programming experience assumed

---

## Part I: Foundations (Chapters 1-4)

### Chapter 1: The Language of Life, The Language of Code
**Goal:** Motivate the course, set up the environment, write first program.

- What is bioinformatics? (DNA sequencing, drug discovery, ancestry, COVID variants)
- Why Python? (readability, ecosystem, industry standard)
- Why AI? (LLM as coding partner, interpreter, and biological reasoning engine)
- Setting up: Python, Jupyter, BioPython, and an AI coding assistant
- First program: print a DNA sequence, count nucleotides
- The AI workflow: prompt -> generate -> test -> understand
- **Lab:** Use an LLM to generate code that counts A/T/G/C in a DNA string. Modify it. Break it. Fix it.
- *Perl reference: example4-1.pl through example4-3.pl*

### Chapter 2: Python Basics Through Biology
**Goal:** Teach core Python concepts using biological data as the context.

- Variables and types (DNA as strings, counts as integers)
- Lists and loops (iterating over nucleotides)
- Conditionals (is this a start codon?)
- Functions (wrap your nucleotide counter)
- File I/O (reading a raw sequence from a file)
- Dictionaries (codon table lookup)
- Error handling (what if the file doesn't exist?)
- **Lab:** Build a function that takes a DNA file and returns nucleotide percentages. Use AI to debug.
- *Perl reference: example4-4.pl through example4-8.pl, example5-1.pl through example5-3.pl*

### Chapter 3: The Central Dogma -- DNA to Protein
**Goal:** Teach biological concepts through code. Translate DNA to protein.

- Biology crash course: DNA -> RNA -> protein (no prerequisites assumed)
- The genetic code as a Python dictionary
- Transcription (DNA to mRNA)
- Translation (codons to amino acids)
- Reading frames (3 forward, 3 reverse)
- Finding open reading frames (ORFs)
- Using BioPython's Seq object and translate()
- **Lab:** Given a mystery DNA sequence, find the protein it encodes. Use AI to predict the protein's function.
- *Perl reference: example6-1.pl through example6-4.pl, codon2aa subroutine*

### Chapter 4: Working with Real Biological Data
**Goal:** Navigate the world's biological databases and file formats.

- FASTA format (headers, sequences, multi-sequence files)
- GenBank format (annotations, features, references)
- Parsing FASTA with BioPython (SeqIO)
- Parsing GenBank records
- NCBI Entrez: searching and downloading sequences programmatically
- Data quality: what do you do with ambiguous nucleotides?
- **Lab:** Download all human hemoglobin sequences from NCBI. Parse them. Count them. Summarize with AI.
- *Perl reference: example8-1.pl through example8-4.pl, example10-1.pl through example10-8.pl*

---

## Part II: Analysis (Chapters 5-8)

### Chapter 5: Comparing Sequences -- Alignment and Similarity
**Goal:** Understand how biologists measure similarity between DNA/protein sequences.

- Why compare sequences? (evolution, function prediction, disease)
- Dot plots (visual intuition for alignment)
- Global alignment (Needleman-Wunsch) -- implement from scratch, then use BioPython
- Local alignment (Smith-Waterman)
- Scoring matrices (BLOSUM, PAM)
- BLAST: searching NCBI databases programmatically
- Interpreting BLAST results with AI (what does E-value mean for a non-scientist?)
- **Lab:** BLAST a mystery protein. Use AI to explain the top hits in plain English.
- *Perl reference: example7-1.pl through example7-4.pl*

### Chapter 6: Sequence Patterns and Motifs
**Goal:** Find recurring patterns in biological sequences.

- Regular expressions for biology (ATG...TAA, restriction sites)
- Motif finding: consensus sequences and position weight matrices
- Restriction enzyme mapping (where does EcoRI cut?)
- CpG islands and regulatory signals
- Using regex in Python on DNA sequences
- Introduction to MEME/HOMER for motif discovery
- **Lab:** Find all restriction enzyme cut sites in a plasmid sequence. Use AI to design primers flanking a target.
- *Perl reference: example5-4.pl through example5-7.pl*

### Chapter 7: Gene Expression and RNA-seq
**Goal:** Understand how biologists measure which genes are active.

- The Central Dogma revisited: why expression matters
- RNA-seq pipeline overview (alignment, counting, normalization)
- Working with count matrices in pandas
- Differential expression: which genes changed?
- Volcano plots and heatmaps with matplotlib/seaborn
- Gene Ontology: what do these genes actually do?
- Using AI to interpret gene lists ("These 50 genes are upregulated -- what pathway might be active?")
- **Lab:** Analyze a small RNA-seq dataset. Generate a volcano plot. Use AI to interpret the top hits.

### Chapter 8: Protein Structure and AlphaFold
**Goal:** Connect sequence to 3D structure using modern AI tools.

- Why structure matters (drug binding, enzyme function)
- PDB format: how proteins are stored
- Fetching structures from RCSB PDB
- AlphaFold: AI predicts structure from sequence
- Visualizing structures (py3Dmol in Jupyter)
- Structure comparison (RMSD)
- Using AI to reason about structure-function relationships
- **Lab:** Predict a protein structure with AlphaFold. Visualize it. Use AI to identify the active site.

---

## Part III: Modern Genomics (Chapters 9-11)

### Chapter 9: Genome Analysis
**Goal:** Work with complete genomes, not just individual genes.

- What is a genome? (scale, complexity, junk DNA debate)
- Genome browsers (UCSC, Ensembl)
- Variant calling basics (SNPs, indels)
- Working with VCF files
- Variant annotation: what does this mutation do?
- Pharmacogenomics introduction (how do variants affect drug response?)
- **Lab:** Analyze variants in a pharmacogene. Use AI to predict clinical significance.

### Chapter 10: Metagenomics and the Microbiome
**Goal:** Analyze mixed communities of organisms.

- What is a microbiome? (gut, soil, ocean)
- 16S rRNA amplicon analysis
- Shotgun metagenomics
- Taxonomic classification (Kraken, MetaPhlAn)
- Diversity metrics (alpha, beta)
- Visualizing microbiome data
- **Lab:** Classify sequences from a mock microbiome sample. Use AI to interpret the community profile.

### Chapter 11: Single-Cell and Spatial Biology
**Goal:** Introduce the frontier of modern biology.

- Why single cells? (heterogeneity, cell types)
- Single-cell RNA-seq overview (10x Genomics)
- Working with AnnData objects (scanpy)
- Clustering and cell type annotation
- Spatial transcriptomics: where are the cells?
- Using AI to annotate cell clusters from marker genes
- **Lab:** Analyze a small single-cell dataset. Identify cell types. Use AI to name the clusters.

---

## Part IV: AI-Native Bioinformatics (Chapters 12-14)

### Chapter 12: LLMs as Biological Reasoning Engines
**Goal:** Use AI not just for coding but for biological interpretation.

- Prompt engineering for biology (how to ask an LLM about a gene, pathway, or disease)
- Literature mining with LLMs (summarize PubMed abstracts)
- Hypothesis generation (given these results, what should I test next?)
- Limitations: hallucinations, outdated knowledge, confidence calibration
- Building a biological Q&A pipeline
- **Lab:** Feed a BLAST result into an LLM. Have it write a mini-literature review.

### Chapter 13: Building Bioinformatics Pipelines
**Goal:** Combine tools into reproducible workflows.

- What is a pipeline? (input -> process -> output)
- Shell scripting for bioinformatics (bash basics)
- Snakemake/Nextflow introduction
- Conda environments for reproducibility
- Container basics (Docker/Singularity)
- Integrating LLM calls into pipelines (API access)
- **Lab:** Build a pipeline that takes raw sequences, runs BLAST, and generates an AI-written summary report.

### Chapter 14: Capstone Projects
**Goal:** End-to-end projects students can showcase.

- Project 1: Trace a disease variant from genome to protein structure
- Project 2: Compare microbiome samples across conditions
- Project 3: Predict protein function from sequence using AI
- Project 4: Build a gene expression analysis dashboard
- Project 5: Design a CRISPR guide RNA and predict off-targets
- Presentation guidelines: how to explain bioinformatics to a non-scientist
- **Lab:** Choose a project. Execute. Present. Use AI throughout.

---

## Appendices

### Appendix A: Python Quick Reference
### Appendix B: BioPython Cheat Sheet
### Appendix C: Linux/Command Line Essentials
### Appendix D: The Perl Legacy (how the original scripts worked, for historical context)
### Appendix E: Glossary of Biological Terms (for non-majors)

---

## Notes on Pedagogical Approach

1. **No biology prerequisites.** Every biological concept is explained from scratch using analogies and visuals. DNA is "a string of four letters." Proteins are "molecular machines."

2. **AI as lab partner, not crutch.** Students write prompts, but they must understand and modify the generated code. Each chapter has "break it, fix it" exercises.

3. **Progressive complexity.** Chapters 1-4 assume zero programming knowledge. By Chapter 11, students are analyzing single-cell data. By Chapter 14, they're building pipelines.

4. **Real data throughout.** Every exercise uses actual biological data from NCBI, PDB, or public repositories. No toy datasets after Chapter 2.

5. **Perl as historical context.** The original Perl scripts are included in an appendix and referenced in footnotes. Students see how the field evolved.

6. **Assessment-ready.** Each chapter ends with a lab that produces a deliverable (code, plot, report) suitable for grading.

---

## Source Material

- 49 working Perl scripts from "Beginning Perl for Bioinformatics" (Tisdall)
- Code snippets from "Mastering Perl for Bioinformatics" (Tisdall)
- BioPython documentation and tutorials
- NCBI, PDB, EBI public APIs
- AlphaFold database
- Scanpy/AnnData ecosystem
