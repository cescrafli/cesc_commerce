import os
import re

screens_dir = 'lib/screens'

print('=== Checking navigation targets ===')
for root, dirs, files in os.walk(screens_dir):
    for fname in sorted(files):
        if not fname.endswith('.dart'):
            continue
        path = os.path.join(root, fname)
        with open(path, 'r', encoding='utf-8', errors='replace') as f:
            content = f.read()
        
        # Find all Navigator pushes
        pushes = re.findall(r'Navigator\.push\w*\([^,]+,\s*(?:MaterialPageRoute\(\s*builder:\s*\([^)]+\)\s*=>\s*)?(\w+)\(', content)
        nav_tos = re.findall(r'context\.go\([^)]+\)|goRouter\.go\([^)]+\)', content)
        
        if pushes or nav_tos:
            print(fname + ': -> ' + str(set(pushes + nav_tos)))
