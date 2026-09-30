import codecs, re

with codecs.open('lib/widgets/product_card.dart', 'r', 'utf-8') as f:
    content = f.read()

content = re.sub(
    r"Navigator\.push\(context, MaterialPageRoute\(builder: \(\_\) => ProductDetailScreen\([^)]+\)\)\);",
    "Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)));",
    content
)

with codecs.open('lib/widgets/product_card.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Done")
