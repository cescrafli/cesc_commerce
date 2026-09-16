import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# We want to replace the literal text: replaceAll('\\$', '')
# with the literal text: replaceAll('\$', '')
find_str = "replaceAll('\\\\\\\\$', '')"
replace_str = "replaceAll('\\\\$', '')"

content = content.replace("replaceAll('\\\\$', '')", "replaceAll('\\\$', '')")

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)
