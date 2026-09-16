import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# Replace any occurrence of replaceAll('\\$', '') with replaceAll('\$', '')
content = content.replace("replaceAll('\\\\\\\\$', '')", "replaceAll('\\\\\\$', '')")

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Fixed again!")
