import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8', errors='ignore') as f:
    content = f.read()

# I will replace the known mojibake sequences.

# Using unicode escapes instead of literal characters in script
content = re.sub(r'A,AA,AA,AA,A', '****', content)
content = re.sub(r'A,AA,AA,A', '***', content)
content = re.sub(r'A,A', '-', content)
content = re.sub(r'A_AA', '-', content)
content = re.sub(r'A,\?\?', '-', content)
content = re.sub(r'A,\?AA,\?A,', 'US', content)
content = re.sub(r'A\?A\?', '>', content)
content = re.sub(r'A\?\?T', '>', content)
content = re.sub(r'A,\?\?A', '!', content)
content = re.sub(r'A,', '!', content)
content = re.sub(r'A,\'A\?', '', content)
content = re.sub(r'A,\?A', '*', content)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Mojibake removed!")
