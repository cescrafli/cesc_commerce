import codecs, glob

for path in glob.glob('lib/screens/**/*.dart', recursive=True):
    with codecs.open(path, 'r', 'utf-8') as f:
        content = f.read()
    changed = False
    
    # Fix all "const X(... tr( ...)" patterns
    # Most common: const Text(tr( -> Text(tr(
    # const SnackBar(content: Text(tr( -> SnackBar(content: Text(tr(
    # const Row(... tr( -> Row(... tr(  (hard to detect generally, do specific ones)
    
    fixes = [
        ('const Text(tr(', 'Text(tr('),
        ('const SnackBar(content: Text(tr(', 'SnackBar(content: Text(tr('),
        ('const Center(child: Text(tr(', 'Center(child: Text(tr('),
        ('const Padding(padding: EdgeInsets', 'Padding(padding: EdgeInsets'),  # if it contains tr() inside
    ]
    for old, new in fixes:
        if old in content:
            content = content.replace(old, new)
            changed = True
    
    if changed:
        with codecs.open(path, 'w', 'utf-8') as f:
            f.write(content)

print("Done")
