import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

pattern = r"'price': item\['price'\],"
replacement = r"'price': double.tryParse(item['price'].toString().replaceAll('\$', '').trim()) ?? 10.0,"

content = re.sub(pattern, replacement, content)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)
