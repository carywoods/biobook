#!/usr/bin/env python3
"""Clean extracted Perl scripts — remove PDF artifacts and prose."""

import os
import re

DIR = "/home/cary/doffice/projects/bioinformatics-book/scripts/extracted"

def is_prose_line(line):
    """Detect lines that are prose, not code."""
    stripped = line.strip()
    if not stripped:
        return False
    # Page numbers
    if re.match(r'^Page\s+\d+$', stripped):
        return True
    # Chapter/section headers
    if re.match(r'^(?:Chapter|Section|Part|Appendix)\s+\d+', stripped):
        return True
    # Figure/table references
    if re.match(r'^(?:Figure|Table|Equation|Example|Listing)\s+\d+', stripped):
        return True
    # Lines that are clearly prose (long sentences without code markers)
    if (len(stripped) > 80 
        and not any(c in stripped for c in ['$', '@', '%', '{', '}', '->', '=>', 'sub ', 'my ', 'use ', 'if ', 'for ', 'while ', 'print ', 'open ', 'close '])
        and not stripped.startswith('#')
        and not stripped.startswith('//')):
        return True
    return False

def clean_script(filepath):
    """Clean a single script file."""
    with open(filepath) as f:
        lines = f.readlines()
    
    cleaned = []
    in_code = False
    for line in lines:
        stripped = line.strip()
        
        # Skip prose lines
        if is_prose_line(line):
            continue
        
        # Skip empty lines at start
        if not in_code and not stripped:
            continue
        
        # Detect code start
        if not in_code and (
            stripped.startswith('#!') 
            or stripped.startswith('use ')
            or stripped.startswith('my ')
            or stripped.startswith('$')
            or stripped.startswith('sub ')
            or stripped.startswith('package ')
            or stripped.startswith('print ')
            or stripped.startswith('open ')
        ):
            in_code = True
        
        if in_code:
            cleaned.append(line)
    
    # Remove trailing empty lines
    while cleaned and not cleaned[-1].strip():
        cleaned.pop()
    
    return ''.join(cleaned)

def main():
    count = 0
    for filename in sorted(os.listdir(DIR)):
        if not filename.endswith('.pl'):
            continue
        filepath = os.path.join(DIR, filename)
        original = open(filepath).read()
        cleaned = clean_script(filepath)
        
        if len(cleaned) < 30:
            # Too short after cleaning — likely noise
            os.remove(filepath)
            print(f"  REMOVED (too short): {filename}")
            continue
        
        if cleaned != original:
            with open(filepath, 'w') as f:
                f.write(cleaned)
            print(f"  CLEANED: {filename} ({len(original)} -> {len(cleaned)} bytes)")
            count += 1
        else:
            print(f"  OK: {filename}")
    
    print(f"\nCleaned {count} files")

if __name__ == "__main__":
    main()
