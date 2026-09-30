import os
import re

screens_dir = 'lib/screens'

print('=== Full button/tap inventory per screen ===')
for root, dirs, files in os.walk(screens_dir):
    for fname in sorted(files):
        if not fname.endswith('.dart'):
            continue
        path = os.path.join(root, fname)
        with open(path, 'r', encoding='utf-8', errors='replace') as f:
            lines = f.readlines()
        
        handlers = []
        for i, line in enumerate(lines):
            stripped = line.strip()
            if re.search(r'onPressed:|onTap:|GestureDetector|InkWell', stripped):
                # Get the next meaningful line too
                action = stripped[:100]
                handlers.append(str(i+1) + ': ' + action)
        
        if handlers:
            print('')
            print('=== ' + fname + ' ===')
            for h in handlers:
                print('  ' + h)
