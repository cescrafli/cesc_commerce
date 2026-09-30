import codecs, re

with codecs.open('lib/widgets/product_card.dart', 'r', 'utf-8') as f:
    content = f.read()

content = content.replace("widget.oldPrice", "oldPrice")

# Fix line 24 manually
lines = content.split('\n')
for i, line in enumerate(lines):
    if 'ProductDetailScreen(' in line:
        lines[i] = "onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product))); },"

content = '\n'.join(lines)
with codecs.open('lib/widgets/product_card.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Done")
