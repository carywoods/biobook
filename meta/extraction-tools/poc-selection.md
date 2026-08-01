# Proof of Concept: 5 Scripts x 2 Versions
# To establish the vanilla/AI pattern before scaling to 84

## Selection

| # | Source | Vanilla | AI | Chapter | Concept |
|---|--------|---------|-----|---------|---------|
| 1 | example4-1.pl | ch02_vanilla_01.py | ch02_ai_01.py | 2 | Store and print DNA |
| 2 | example8-1.pl | ch03_vanilla_01.py | ch03_ai_01.py | 3 | Translate codons to protein |
| 3 | example8-4.pl | ch03_vanilla_02.py | ch03_ai_02.py | 3 | Six reading frames |
| 4 | example5-4.pl | ch05_vanilla_01.py | ch05_ai_01.py | 5 | Nucleotide frequency |
| 5 | example10-1.pl | ch04_vanilla_01.py | ch04_ai_01.py | 4 | Parse GenBank file |

## Naming Convention
ch{chapter}_vanilla_{sequence}.py  -- standard Python
ch{chapter}_ai_{sequence}.py       -- LLM-assisted version
