import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8', errors='ignore') as f:
    lines = f.readlines()

for i, line in enumerate(lines):
    # Search for anything looking like mojibake, e.g. Ã or A
    if re.search(r"A\xef\xbf\xbd", line) or "A" in line or "Ã" in line or "" in line:
        print(f"Line {i+1}: {line.strip()}")
