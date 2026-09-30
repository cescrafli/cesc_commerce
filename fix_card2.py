import codecs, re

with codecs.open('lib/widgets/product_card.dart', 'r', 'utf-8') as f:
    content = f.read()

# Fix interpolation syntax
content = content.replace("'$product['reviews'].toString()'", "'${product['reviews'].toString()}'")
content = content.replace("($product['reviews'].toString())", "(${product['reviews'].toString()})")
content = content.replace("'$product['price'].toStringAsFixed(2)'", "'${product['price'].toStringAsFixed(2)}'")
content = content.replace("\\$${product['price'].toStringAsFixed(2)}", "\\$${product['price'].toStringAsFixed(2)}") 

# Fix missing variables in ProductCard
content = re.sub(r"\b(oldPrice)\b", r"widget.\1", content) # wait, it's a StatelessWidget, so just use `oldPrice`
# The problem was my fix_card_filter.py didn't actually add tag1, tag2, oldPrice back properly because it didn't match the exact constructor!
constructor_replacement = "final Map<String, dynamic> product;\n  final String tag1;\n  final String tag2;\n  final String oldPrice;\n\n  const ProductCard({super.key, required this.product, this.tag1 = '', this.tag2 = '', this.oldPrice = ''});"
content = re.sub(r"final Map<String, dynamic> product;[\s\n]*const ProductCard\(\{super\.key, required this\.product\}\);", constructor_replacement, content)

with codecs.open('lib/widgets/product_card.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Done")
