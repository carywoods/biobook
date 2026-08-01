#!/usr/bin/env python3
"""
Phase 3 extraction: Use font information to distinguish code from prose.
PDF books typically use monospace fonts (Courier) for code and serif (Times) for prose.
"""

import re
import os
import sys
import fitz  # pymupdf

PDFS = {
    "mastering-perl": "/home/cary/doffice/projects/bioinformatics-book/pdfs/mastering-perl-for-bioinformatics.pdf",
    "biocomputing-perl": "/home/cary/doffice/projects/bioinformatics-book/pdfs/bioinformatics-biocomputing-perl.pdf",
}

OUT_DIR = "/home/cary/doffice/projects/bioinformatics-book/scripts/extracted_v2"

def is_mono_font(fontname):
    """Check if a font name indicates monospace (code) font."""
    mono_keywords = ['courier', 'mono', 'consol', 'lucida', 'typewriter', 'cour']
    fn = fontname.lower()
    return any(k in fn for k in mono_keywords)

def extract_with_fonts(pdf_path):
    """Extract text blocks with font information."""
    doc = fitz.open(pdf_path)
    pages_text = []
    
    for page_num, page in enumerate(doc):
        blocks = page.get_text("dict")["blocks"]
        page_lines = []
        
        for block in blocks:
            if block["type"] != 0:  # text block
                continue
            for line in block.get("lines", []):
                spans = line.get("spans", [])
                if not spans:
                    continue
                
                # Determine if this line is code based on font
                line_text = ""
                is_code = False
                max_size = 0
                
                for span in spans:
                    text = span.get("text", "")
                    font = span.get("font", "")
                    size = span.get("size", 0)
                    line_text += text
                    max_size = max(max_size, size)
                    if is_mono_font(font):
                        is_code = True
                
                line_text = line_text.strip()
                if line_text:
                    page_lines.append({
                        "text": line_text,
                        "is_code": is_code,
                        "size": max_size,
                        "page": page_num + 1
                    })
        
        pages_text.append(page_lines)
    
    doc.close()
    return pages_text

def extract_code_blocks(pages_text):
    """Group consecutive code lines into blocks."""
    all_lines = []
    for page_lines in pages_text:
        all_lines.extend(page_lines)
    
    blocks = []
    current_block = []
    current_start = 0
    
    for i, line in enumerate(all_lines):
        if line["is_code"]:
            if not current_block:
                current_start = i
            current_block.append(line)
        else:
            if current_block and len(current_block) >= 3:  # At least 3 code lines
                blocks.append({
                    "lines": current_block,
                    "start": current_start,
                    "end": i - 1,
                    "page_start": current_block[0]["page"],
                    "page_end": current_block[-1]["page"]
                })
            current_block = []
    
    # Don't forget last block
    if current_block and len(current_block) >= 3:
        blocks.append({
            "lines": current_block,
            "start": current_start,
            "end": len(all_lines) - 1,
            "page_start": current_block[0]["page"],
            "page_end": current_block[-1]["page"]
        })
    
    return blocks

def has_perl_syntax(text):
    """Check if text contains Perl syntax markers."""
    perl_markers = [
        r'^#!.*perl',
        r'^use\s+(strict|warnings|Bio|DBI|CGI|Getopt)',
        r'\$\w+',           # scalar variables
        r'@\w+',            # array variables  
        r'%\w+',            # hash variables
        r'sub\s+\w+',       # subroutines
        r'(my|our|local)\s+[\$@%]',  # variable declarations
        r'->\{',            # hash dereference
        r'=>',              # fat comma
        r'print\s+["\']',   # print statements
        r'if\s*\(',         # if statements
        r'while\s*\(',      # while loops
        r'for(each)?\s+',   # for loops
        r'open\s*\(',       # file operations
        r'=~\s*[ms]?/',     # regex operations
    ]
    for marker in perl_markers:
        if re.search(marker, text):
            return True
    return False

def is_prose_line(text):
    """Detect lines that are clearly prose, not code."""
    stripped = text.strip()
    if not stripped:
        return False
    # Book section references (e.g., "2.2.5.1 Anonymous")
    if re.match(r'^\d+\.\d+(\.\d+)*\s+[A-Z]', stripped):
        return True
    # Figure/table references
    if re.match(r'^(Figure|Table|Example|Listing|Program)\s+\d+', stripped):
        return True
    # Page numbers
    if re.match(r'^\d+$', stripped):
        return True
    # Chapter headers
    if re.match(r'^Chapter\s+\d+', stripped):
        return True
    # Team LiB markers
    if 'Team LiB' in stripped:
        return True
    # Lines starting with footnote numbers
    if re.match(r'^\d[A-Z]', stripped) and len(stripped) > 30:
        return True
    # Long sentences without code markers
    if (len(stripped) > 80 
        and not any(c in stripped for c in ['$', '@', '%', '{', '}', '->', '=>', 'sub ', 'my ', 'use ', 'if ', 'print '])
        and not stripped.startswith('#')
        and not stripped.startswith('//')):
        return True
    return False

def clean_code(text):
    """Clean extracted code text."""
    # Replace common Unicode artifacts
    text = text.replace('\u2018', "'").replace('\u2019', "'")
    text = text.replace('\u201c', '"').replace('\u201d', '"')
    text = text.replace('\u2013', '-').replace('\u2014', '-')
    text = text.replace('\ufb01', 'fi').replace('\ufb02', 'fl')
    text = text.replace('\u200b', '').replace('\u200c', '').replace('\u200d', '')
    text = text.replace('\xa0', ' ')
    # Strip remaining non-ASCII
    text = text.encode('ascii', 'ignore').decode('ascii')
    return text

def save_blocks(blocks, book_name):
    """Save extracted code blocks to files."""
    os.makedirs(OUT_DIR, exist_ok=True)
    
    count = 0
    for block in blocks:
        # Get text from lines
        raw_text = '\n'.join(line["text"] for line in block["lines"])
        
        # Check if this block has Perl syntax
        if not has_perl_syntax(raw_text):
            continue
        
        # Clean the text
        code = clean_code(raw_text)
        
        # Remove prose lines that snuck in
        lines = code.split('\n')
        clean_lines = []
        for line in lines:
            if not is_prose_line(line):
                clean_lines.append(line)
        
        code = '\n'.join(clean_lines).strip()
        
        # Skip if too short after cleaning
        if len(code) < 50:
            continue
        
        count += 1
        filename = f"{book_name}_v2_{count:03d}.pl"
        filepath = os.path.join(OUT_DIR, filename)
        
        with open(filepath, 'w') as f:
            f.write(code + '\n')
        
        pages = f"p{block['page_start']}" 
        if block['page_end'] != block['page_start']:
            pages += f"-{block['page_end']}"
        print(f"  {filename}: {len(code)} bytes, {len(clean_lines)} lines ({pages})")
    
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
        
        pages_text = extract_with_fonts(pdf_path)
        total_lines = sum(len(p) for p in pages_text)
        code_lines = sum(1 for p in pages_text for l in p if l["is_code"])
        print(f"  Extracted {total_lines} lines total, {code_lines} in monospace font")
        
        blocks = extract_code_blocks(pages_text)
        print(f"  Found {len(blocks)} code blocks (3+ consecutive monospace lines)")
        
        count = save_blocks(blocks, book_name)
        total += count
        print(f"  Saved {count} Perl scripts")
    
    print(f"\n{'='*60}")
    print(f"TOTAL: {total} scripts saved to {OUT_DIR}")

if __name__ == "__main__":
    main()
