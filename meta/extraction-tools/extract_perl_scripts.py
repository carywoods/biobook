#!/usr/bin/env python3
"""Extract Perl scripts from bioinformatics book PDFs."""

import re
import os
import fitz  # pymupdf

PDFS = {
    "mastering-perl": "/home/cary/doffice/projects/bioinformatics-book/pdfs/mastering-perl-for-bioinformatics.pdf",
    "biocomputing-perl": "/home/cary/doffice/projects/bioinformatics-book/pdfs/bioinformatics-biocomputing-perl.pdf",
}

OUT_DIR = "/home/cary/doffice/projects/bioinformatics-book/scripts/extracted"

def extract_text(pdf_path):
    """Extract all text from PDF."""
    doc = fitz.open(pdf_path)
    text = ""
    for page in doc:
        text += page.get_text() + "\n"
    doc.close()
    return text

def find_perl_scripts(text, book_name):
    """Find Perl script blocks in extracted text."""
    scripts = []
    
    # Pattern 1: Shebang lines
    shebang_pattern = re.compile(
        r'(#!/usr/bin/(?:env )?perl[^\n]*\n(?:.*?\n)*?)(?=\n\n|\n#====|\n[A-Z]|\n---|\Z)',
        re.MULTILINE | re.DOTALL
    )
    
    # Pattern 2: Code blocks that start with common Perl patterns
    # Look for blocks that start with shebang or use statements and contain Perl syntax
    perl_block_pattern = re.compile(
        r'((?:#!/usr/bin/(?:env )?perl[^\n]*\n|'
        r'use\s+(?:strict|warnings|Bio::|Getopt|FileHandle|DBI|CGI)[^\n]*\n)'
        r'(?:.*?\n)*?'
        r')(?=\n\n|\n[A-Z][a-z]|\n---|\n===|\Z)',
        re.MULTILINE | re.DOTALL
    )
    
    # Pattern 3: Named scripts (e.g., "Example 4-1. scriptname.pl")
    named_script_pattern = re.compile(
        r'(?:Example|Listing|Program)\s*[\d\-\.]+[:\s]*([\w\-\.]+\.pl)\s*\n(.*?)(?=\n\n(?:Example|Listing|Program|[A-Z][a-z]|\d+\.\s+[A-Z])|\Z)',
        re.MULTILINE | re.DOTALL
    )
    
    # Collect all matches
    seen = set()
    
    for match in shebang_pattern.finditer(text):
        code = match.group(0).strip()
        if len(code) > 50 and code not in seen:
            seen.add(code)
            scripts.append(("shebang", code))
    
    for match in perl_block_pattern.finditer(text):
        code = match.group(0).strip()
        if len(code) > 50 and code not in seen:
            seen.add(code)
            scripts.append(("block", code))
    
    for match in named_script_pattern.finditer(text):
        name = match.group(1)
        code = match.group(2).strip()
        if len(code) > 30:
            scripts.append(("named", code, name))
    
    return scripts

def clean_script(text):
    """Clean extracted text into valid Perl."""
    # Remove common PDF extraction artifacts
    lines = text.split('\n')
    cleaned = []
    for line in lines:
        # Remove page numbers
        if re.match(r'^\s*\d+\s*$', line):
            continue
        # Remove chapter headers
        if re.match(r'^\s*Chapter\s+\d+', line):
            continue
        # Remove figure/equation references
        if re.match(r'^(?:Figure|Equation|Table)\s+\d+', line):
            continue
        cleaned.append(line)
    return '\n'.join(cleaned).strip()

def save_scripts(scripts, book_name):
    """Save extracted scripts to files."""
    os.makedirs(OUT_DIR, exist_ok=True)
    
    count = 0
    for item in scripts:
        if item[0] == "named":
            _, code, name = item
            filename = f"{book_name}_{name}"
        else:
            _, code = item
            count += 1
            filename = f"{book_name}_script_{count:03d}.pl"
        
        code = clean_script(code)
        if not code.endswith('.pl'):
            if not filename.endswith('.pl'):
                filename += '.pl'
        
        filepath = os.path.join(OUT_DIR, filename)
        with open(filepath, 'w') as f:
            f.write(code)
        print(f"  Saved: {filename} ({len(code)} bytes)")
    
    return count

def main():
    total = 0
    for book_name, pdf_path in PDFS.items():
        print(f"\n{'='*60}")
        print(f"Processing: {book_name}")
        print(f"PDF: {pdf_path}")
        
        if not os.path.exists(pdf_path):
            print(f"  ERROR: PDF not found!")
            continue
        
        text = extract_text(pdf_path)
        print(f"  Extracted {len(text)} chars of text")
        
        scripts = find_perl_scripts(text, book_name)
        print(f"  Found {len(scripts)} potential Perl script blocks")
        
        count = save_scripts(scripts, book_name)
        total += count
        print(f"  Saved {count} scripts")
    
    print(f"\n{'='*60}")
    print(f"TOTAL: {total} scripts extracted")
    print(f"Output: {OUT_DIR}")

if __name__ == "__main__":
    main()
