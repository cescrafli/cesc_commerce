# coding=utf-8
import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8', errors='ignore') as f:
    lines = f.readlines()

for i, line in enumerate(lines):
    if "A,A" in line or "" in line or "A" in line:
        # wait, "A" is everywhere. 
        pass

for i, line in enumerate(lines):
    if u'\ufffd' in line:
        print(f"Line {i+1}: {line.strip()}")
