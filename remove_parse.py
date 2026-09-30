import codecs, re
with codecs.open('lib/screens/product/product_detail_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

content = re.sub(r'try \{ price = double\.parse[^\}]+} catch\(e\) {}', '', content)

with codecs.open('lib/screens/product/product_detail_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
