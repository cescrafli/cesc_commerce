import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

content = content.replace("Text('Order Items (\)',", "Text('Order Items (\)',")

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Fixed order items length!")
