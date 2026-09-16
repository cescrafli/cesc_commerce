import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

content = content.replace("height: 180,", "height: 200,")

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)
