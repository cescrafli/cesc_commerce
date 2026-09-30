import os
import re

screens_dir = 'lib/screens'

for root, dirs, files in os.walk(screens_dir):
    for fname in sorted(files):
        if not fname.endswith('.dart'):
            continue
        path = os.path.join(root, fname)
        with open(path, 'r', encoding='utf-8', errors='replace') as f:
            content = f.read()
        
        issues = []
        
        empty_handlers = re.findall(
            r'onPressed:\s*null|onTap:\s*null|onPressed:\s*\(\)\s*\{\s*\}|onTap:\s*\(\)\s*\{\s*\}',
            content
        )
        if empty_handlers:
            issues.append('EMPTY_HANDLER: ' + str(len(empty_handlers)) + ' instances')

        todos = re.findall(r'//\s*TODO.+', content)
        if todos:
            issues.append('TODO: ' + str(len(todos)) + ' found: ' + todos[0][:70])

        placeholders = re.findall(
            r'Lorem ipsum|example\.com|dummy|placeholder', content, re.IGNORECASE
        )
        if placeholders:
            issues.append('PLACEHOLDER_DATA: ' + str(len(placeholders)) + ' instances')

        if issues:
            print('=== ' + fname + ' ===')
            for iss in issues:
                print('  - ' + iss)

print('Scan complete.')
