import re

# Read as raw bytes
with open('lib/main.dart', 'rb') as f:
    raw = f.read()

# Replace all occurrences of literal \xc3\xa2\xe2\x82\xac or similar.
# Actually, let's decode using utf-8 with replacement so we get \ufffd
text = raw.decode('utf-8', errors='replace')

# Now text has \ufffd instead of invalid bytes.
# We want to replace ANY combination of A, \ufffd, and commas that look like mojibake.
# For example, 'A\ufffd,\ufffdA\ufffd'
# Let's just use a regex that matches: A followed by any mix of \ufffd, commas, A, ?, T, etc that matches the known mojibake!
# Actually, it's easier to just match: r'A\ufffd[^\s\w]*A\ufffd' etc.
# Let's write a function to replace these specific patterns.

patterns = [
    (r'(?:A\ufffd,\ufffdA\ufffd){4}', '****'),
    (r'(?:A\ufffd,\ufffdA\ufffd){3}', '***'),
    (r'(?:A\ufffd,\ufffdA\ufffd){2}', '**'),
    (r'A\ufffd,\ufffdA\ufffd', '-'),
    (r'A_A\ufffdA\ufffd', '-'),
    (r'A\ufffd,\ufffd\?\?A\ufffd', '!'),
    (r'A\ufffd,\ufffd\?\?', '-'),
    (r'A\ufffd,\ufffd\?A\ufffd', '*'),
    (r'A\ufffd\?A\ufffd', '>'),
    (r'A\ufffd\?\?T', '>'),
    (r'A\ufffd,\ufffd', '!'),
    (r'A\ufffd,\ufffd\'A\?', ''),
    (r'A\ufffd,\ufffd\?\ufffdA\ufffdA\ufffd,\ufffd\?\ufffdA,', 'US'),
]

for p, repl in patterns:
    text = re.sub(p, repl, text)

# Write back
with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(text)

print("Mojibake fully removed via regex!")
