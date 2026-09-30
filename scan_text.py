import glob
import re

for filepath in glob.glob('lib/screens/**/*.dart', recursive=True):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    matches = re.findall(r"Text\(\s*'([^']+)'", content)
    matches += re.findall(r'Text\(\s*"([^"]+)"', content)
    
    # Also find Text(tr('key')) to avoid replacing them
    tr_matches = re.findall(r"Text\(\s*tr\('([^']+)'", content)
    
    valid_matches = [m for m in matches if len(m) > 1 and not m.startswith('$') and m not in tr_matches]
    
    if valid_matches:
        print(filepath)
        for m in set(valid_matches):
            print(f'  - {m}')
