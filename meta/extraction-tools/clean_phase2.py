#!/usr/bin/env python3
"""Phase 2 cleanup: strip Unicode artifacts and remaining prose from Perl scripts."""

import os
import re

DIR = "/home/cary/doffice/projects/bioinformatics-book/scripts/extracted"

def clean_unicode(text):
    """Replace common PDF Unicode artifacts."""
    # Smart quotes -> straight quotes
    text = text.replace('\u2018', "'").replace('\u2019', "'")
    text = text.replace('\u201c', '"').replace('\u201d', '"')
    # Em/en dashes -> hyphens
    text = text.replace('\u2013', '-').replace('\u2014', '-')
    # Ligatures
    text = text.replace('\ufb01', 'fi').replace('\ufb02', 'fl')
    # Zero-width chars
    text = text.replace('\u200b', '').replace('\u200c', '').replace('\u200d', '')
    # Non-breaking spaces
    text = text.replace('\xa0', ' ')
    # Bullet points
    text = text.replace('\u2022', '#')
    # Any remaining non-ASCII -> remove
    text = text.encode('ascii', 'ignore').decode('ascii')
    return text

def is_prose_line(line):
    """Detect prose lines that shouldn't be in code."""
    stripped = line.strip()
    if not stripped:
        return False
    # Lines starting with footnote-style numbers like "9It", "2. Write"
    if re.match(r'^\d[A-Z]', stripped):
        return True
    # Lines that are clearly book section references
    if re.match(r'^\d+\.\d+\.\d+', stripped):
        return True
    # Lines with [ Team LiB ] markers
    if '[ Team LiB ]' in stripped:
        return True
    # Lines like "Here is the output:" or "The output shows:"
    if re.match(r'^(Here is|The output|This (?:program|script)|Note that|The following)', stripped):
        return True
    return False

def clean_file(filepath):
    """Clean a single Perl script."""
    with open(filepath, 'r') as f:
        text = f.read()
    
    original = text
    text = clean_unicode(text)
    
    lines = text.split('\n')
    cleaned = []
    for line in lines:
        if is_prose_line(line):
            continue
        cleaned.append(line)
    
    result = '\n'.join(cleaned)
    
    if result != original:
        with open(filepath, 'w') as f:
            f.write(result)
        return True
    return False

def main():
    changed = 0
    for f in sorted(os.listdir(DIR)):
        if not f.endswith('.pl'):
            continue
        path = os.path.join(DIR, f)
        if clean_file(path):
            changed += 1
            print(f"  CLEANED: {f}")
    print(f"\nPhase 2 cleaned {changed} files")

if __name__ == "__main__":
    main()
