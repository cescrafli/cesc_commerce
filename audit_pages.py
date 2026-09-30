import os

screens_dir = 'lib/screens'
results = []

for root, dirs, files in os.walk(screens_dir):
    for fname in files:
        if not fname.endswith('.dart'): continue
        path = os.path.join(root, fname)
        with open(path, 'r', encoding='utf-8', errors='replace') as f:
            content = f.read()
        
        has_tr = "tr('" in content
        has_vlb = 'ValueListenableBuilder' in content and 'globalLanguage' in content
        has_listener = '_onLangChange' in content
        
        if not has_tr:
            status = 'NO_TR'
        elif has_vlb:
            status = 'VLB_OK'
        elif has_listener:
            status = 'LISTENER_OK'
        else:
            status = 'MISSING'
        
        results.append((status, path))

for status, path in sorted(results, key=lambda x: (x[0] != 'MISSING', x[0])):
    print(status + '  ' + path)
